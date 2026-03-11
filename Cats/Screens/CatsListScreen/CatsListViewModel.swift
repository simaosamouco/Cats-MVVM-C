//
//  CatsListViewModel.swift
//  Cats
//
//  Created by Simão Neves Samouco on 19/09/2025.
//

import Combine
import Foundation

enum LoadingType {
    case initial
    case pagination
}

protocol CatsListViewModelProtocol: ObservableObject {
    
    var publishedCats: [CatCellViewModel] { get }
    var isLoading: Bool { get }
    var isLoadingPagination: Bool { get }
    var searchText: String { get set }
    
    func onFirstAppear()
    func didTapCat(_ cat: CatCellViewModel)
    func didTapBookmarkButton()
    func didShowCat(_ cat: CatCellViewModel)
    
}

final class CatsListViewModel: CatsListViewModelProtocol {
    
    /// Vars published to the `View`
    @Published var publishedCats: [CatCellViewModel] = []
    @Published var isLoading: Bool = false
    @Published var isLoadingPagination: Bool = false
    @Published var searchText = ""
    
    /// Internal State vars
    private var catsModels: [Cat] = []
    private var catCellViewModels: [CatCellViewModel] = []
    private var catsPage: Int = 0
    private var cancellables = Set<AnyCancellable>()
    private var getCatsTask: Task<Void, Never>?
    
    /// ViewModel dependencies
    private let coordinator: CatsListCoordinatorProtocol
    private let getCatsUseCase: GetCatsUseCaseProtocol
    private let getImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol
    private let catFilterUseCase: CatFilterUseCaseProtocol
    
    init(coordinator: CatsListCoordinatorProtocol,
         getCatsUseCase: GetCatsUseCaseProtocol,
         getImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol,
         catFilterUseCase: CatFilterUseCaseProtocol) {
        self.coordinator = coordinator
        self.getCatsUseCase = getCatsUseCase
        self.getImageFromUrlUseCase = getImageFromUrlUseCase
        self.catFilterUseCase = catFilterUseCase
        setupSearchBinding()
    }
    
    deinit {
        getCatsTask?.cancel()
    }
    
    // MARK: - Public methods
    func onFirstAppear() {
        getCats(for: .initial)
    }
    
    /// Called by the `View` to change Tab
    func didTapBookmarkButton() {
        coordinator.changeTab(to: .savedCats)
    }
   
    /// Called by the `View` when a cell gets tapped
    func didTapCat(_ cat: CatCellViewModel) {
        guard let catModel = getCatModel(for: cat) else { return }
        coordinator.goToCatProfile(catModel)
    }
    
    /// Called by the `View` whenever a new CatCell is displayed.
    /// If the `searchText` is not empty then it will compare the displayed Cat ID with the ID from the last cat on the published cats array
    /// If equal it fetches aditional Cats from the server as pagination.
    func didShowCat(_ cat: CatCellViewModel) {
        guard searchText.isEmpty,
              cat.id == publishedCats.last?.id,
              !isLoadingPagination else { return }
        getCats(for: .pagination)
    }
    
    // MARK: - Private methods
    
    /// Fetches cats from the API, updates the list, and manages loading state.
    private func getCats(for type: LoadingType) {
        getCatsTask?.cancel()
        getCatsTask = Task {
            toggleLoading(for: type, to: true)
            defer { toggleLoading(for: type, to: false) }
            do {
                let cats = try await getCatsUseCase.get(for: catsPage)
                catsModels.append(contentsOf: cats)
                updateCats(with: cats)
                catsPage += 1
            } catch {
                coordinator.showError(error)
            }
        }
    }
    
    /// Binds `searchText` to `publishedCats`, filtering results with debounce to update efficiently.
    private func setupSearchBinding() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { [weak self] searchText -> [CatCellViewModel] in
                guard let self = self else { return [] }
                return self.catFilterUseCase.filter(cats: self.catCellViewModels,
                                                    by: searchText)
            }
            .sink { [weak self] filtered in
                self?.publishedCats = filtered
            }
            .store(in: &cancellables)
    }

    /// Given an array of `Cat` transforms it into and an array of `CatCellViewModel`
    /// Updates the view model storage with new values
    private func updateCats(with cats: [Cat]) {
        Task { @MainActor in
            let newViewModels = createViewModels(from: cats)
            self.catCellViewModels.append(contentsOf: newViewModels)
            self.publishedCats = catCellViewModels
        }
    }

    /// Transforms an array of `Cat` into `CatCellViewModel`.
    private func createViewModels(from cats: [Cat]) -> [CatCellViewModel] {
        cats.compactMap {
            CatCellViewModel(
                id: $0.id,
                url: $0.url,
                breedName: $0.breedName,
                getImageFromUrlUseCase: getImageFromUrlUseCase
            )
        }
    }
  
    /// Updates the `Loading` state for the whole view or pagination
    private func toggleLoading(for type: LoadingType, to isLoading: Bool) {
        switch type {
        case .initial:
            Task { @MainActor in
                self.isLoading = isLoading
            }
        case .pagination:
            Task { @MainActor in
                self.isLoadingPagination = isLoading
            }
        }
    }
    
    /// Returns the `Cat` model matching the given `CatCellViewModel` ID
    private func getCatModel(for cell: CatCellViewModel) -> Cat? {
        catsModels.first(where: { $0.id == cell.id })
    }
   
}
