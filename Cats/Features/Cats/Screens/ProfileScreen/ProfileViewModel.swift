//
//  ProfileViewModel.swift
//  Cats
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
        checkCatSavedStatus()
        loadImage()
    }
    
    /// Called by the `ViewController` on `viewWillAppear`
    /// to update the navigation bar item based on the `Cat` saved status in device memory.
    func checkCatSavedStatus() {
        Task { @MainActor in
            do {
                isCatSaved = try await self.catsPersistanceUseCase.isCatSaved(id: cat.id)
            } catch {
                coordinator.showError(error)
            }
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
