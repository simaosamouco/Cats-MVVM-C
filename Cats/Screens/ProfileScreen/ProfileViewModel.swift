//
//  ProfileViewModel.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/08/2025.
//

import SwiftUI

protocol ProfileViewModelProtocol: ObservableObject {
    var image: UIImage? { get }
    var breedName: String { get }
    var breedDescription: String { get }
    var toolBarImage: Image { get }
    var showContent: Bool { get }
    
    func didTapSaveButton()
    func checkCatSavedStatus() async
}

final class ProfileViewModel: ProfileViewModelProtocol {
    
    @Published var image: UIImage?
    @Published var isCatSaved: Bool = false
    let breedName: String
    let breedDescription: String
    var showContent: Bool { image != nil }
    var toolBarImage: Image {
        isCatSaved ? Image(systemName: "bookmark.fill") : Image(systemName: "bookmark")
    }
    
    /// Internal State vars
    private let cat: CatProfileModel
    
    /// ViewModel dependencies
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
        loadImage()
    }
    
    /// Called by the `View` on `.task`
    /// to update the navigation bar item based on the `Cat` saved status in device memory.
    func checkCatSavedStatus() async {
        do {
            let saved = try await catsPersistanceUseCase.isCatSaved(id: cat.id)
            await MainActor.run {
                isCatSaved = saved
            }
        } catch {
            coordinator.showError(error)
        }
    }
    
    /// Loads the `Cat`s image using the `GetImageFromUrlUseCaseProtocol`
    func loadImage() {
        Task { @MainActor in
            self.image = await getImageFromUrlUseCase.get(from: cat.url)
        }
    }
    
    /// Called by the `ViewController` when the trailing navigation item gets tapped
    /// Based on the saved status calls delete or save cat methods
    /// Displays error message case it fails.
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
    
    /// Attempts to delete `Cat` from device memory
    private func deleteCat() async throws {
        try await catsPersistanceUseCase.deleteCat(
            id: cat.id,
            url: cat.url,
            breedName: cat.breedName
        )
    }
    
    /// Attempts to save `Cat` in device memory
    private func saveCat() async throws {
        try await catsPersistanceUseCase.saveCat(
            id: cat.id,
            url: cat.url,
            breedName: cat.breedName,
            breedDescription: cat.breedDescription
        )
    }
    
}
