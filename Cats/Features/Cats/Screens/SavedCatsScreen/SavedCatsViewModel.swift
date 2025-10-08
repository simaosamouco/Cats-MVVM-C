//
//  SavedCatsViewModel.swift
//  Cats
//
//  Created by Simão Neves Samouco on 19/09/2025.
//

import Foundation

protocol SavedCatsViewModelProtocol: ObservableObject {
    var cats: [CatCellViewModel] { get }
    var isLoading: Bool { get }
    func getSavedCats()
    func didTapCat(_ cat: CatCellViewModel)
}

final class SavedCatsViewModel: SavedCatsViewModelProtocol {
    
    /// Vars published to the `View`
    @Published var cats: [CatCellViewModel] = []
    @Published var isLoading: Bool = false
    
    /// Internal State Vars
    private var catsModels: [Cat] = []
    
    /// ViewModel Dependencies
    private let coordinator: SavedCatsCoordinatorProtocol
    private let catsPersistanceUseCase: CatsPersistanceUseCaseProtocol
    private let getImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol
    
    init(coordinator: SavedCatsCoordinatorProtocol,
         catsPersistanceUseCase: CatsPersistanceUseCaseProtocol,
         getImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol) {
        self.coordinator = coordinator
        self.catsPersistanceUseCase = catsPersistanceUseCase
        self.getImageFromUrlUseCase = getImageFromUrlUseCase
    }
    
    /// Fetches cats from the devices memory, updates the list, and manages loading state.
    func getSavedCats() {
        Task {
            toggleLoading(to: true)
            defer { toggleLoading(to: false) }
            do {
                let savedCats = try await catsPersistanceUseCase.fetchCats()
                self.catsModels = savedCats
                let catCellViewModels = createViewModels(from: savedCats)
                Task { @MainActor in
                    self.cats = catCellViewModels
                }
            } catch {
                coordinator.showError(error)
            }
        }
    }
    
    /// Called by the `View` when a cell gets tapped
    func didTapCat(_ cat: CatCellViewModel) {
        /// Gets the `Cat` model with the same `ID` as the `CatCell` to pass on the navigation
        guard let catModel: Cat = catsModels.first(where: { $0.id == cat.id }) else { return }
        coordinator.goToCatProfile(catModel)
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
    
    /// Updates the `Loading` state
    private func toggleLoading(to state: Bool) {
        Task { @MainActor in
            isLoading = state
        }
    }
    
}
