//
//  ProfileViewModel.swift
//  DogsTest
//
//  Created by Simão Neves Samouco on 08/08/2025.
//

import UIKit

protocol ProfileViewModelProtocol: ObservableObject {
    var image: UIImage? { get }
    var breedName: String { get }
    var breedDescription: String { get }
    
    var isCatSavedPublisher: Published<Bool>.Publisher { get }
    
    func didTapSaveButton()
    func checkCatSavedStatus()
}

final class ProfileViewModel: ProfileViewModelProtocol {
    
    @Published var image: UIImage?
    @Published var isCatSaved: Bool = false
    var isCatSavedPublisher: Published<Bool>.Publisher { $isCatSaved }
    let breedName: String
    let breedDescription: String
    
    private let cat: CatProfileModel
    
    private let coordinator: ProfileViewCoordinatorProtocol
    private let catsPersistanceUseCase: CatsPersistanceUseCaseProtocol
    private let getImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol
    
    init(catProfile: CatProfileModel,
         coordinator: ProfileViewCoordinatorProtocol,
         catsPersistanceUseCase: CatsPersistanceUseCaseProtocol,
         getImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol) {
        self.cat = catProfile
        self.coordinator = coordinator
        self.catsPersistanceUseCase = catsPersistanceUseCase
        self.getImageFromUrlUseCase = getImageFromUrlUseCase
        self.breedName = cat.breedName
        self.breedDescription = cat.breedDescription
        checkCatSavedStatus()
        loadImage()
    }
    
    func checkCatSavedStatus() {
        Task { @MainActor in
            do {
                isCatSaved = try await self.catsPersistanceUseCase.isCatSaved(id: cat.id)
            } catch {
                coordinator.showError(error)
            }
        }
    }
    
    func loadImage() {
        Task { @MainActor in
            self.image = await getImageFromUrlUseCase.get(from: cat.url)
        }
    }
    
    func didTapSaveButton() {
        Task {
            do {
                isCatSaved ? try await deleteCat() : try await saveCat()
                await MainActor.run {
                    isCatSaved.toggle()
                }
            } catch {
                coordinator.showError(error)
            }
        }
    }
    
    private func deleteCat() async throws {
        try await catsPersistanceUseCase.deleteCat(
            id: cat.id,
            url: cat.url,
            breedName: cat.breedName
        )
    }
    
    private func saveCat() async throws {
        try await catsPersistanceUseCase.saveCat(
            id: cat.id,
            url: cat.url,
            breedName: cat.breedName,
            breedDescription: cat.breedDescription
        )
    }
    
}
