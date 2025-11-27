//
//  CatCellViewModel.swift
//  Cats
//
//  Created by Simão Neves Samouco on 07/08/2025.
//

import SwiftUI

protocol CatCellViewModelProtocol: ObservableObject {
    var image: UIImage? { get }
    var breedName: String { get }
    var id: String { get }
    
    func loadImage()
    func onDisappear()
}

final class CatCellViewModel: CatCellViewModelProtocol {
    
    @Published var image: UIImage?
    let breedName: String
    let url: String
    let id: String
    
    private let getImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol
    private var imageLoadTask: Task<Void, Never>?
    
    init(id: String,
         url: String,
         breedName: String,
         getImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol) {
        self.id = id
        self.url = url
        self.breedName = breedName
        self.getImageFromUrlUseCase = getImageFromUrlUseCase
    }
    
    func loadImage() {
        imageLoadTask?.cancel()
        
        imageLoadTask = Task { @MainActor in
            guard !Task.isCancelled else { return }
            self.image = await getImageFromUrlUseCase.get(from: url)
        }
    }
    
    func onDisappear() {
        clearImage()
        cancelImageLoad()
    }
    
    private func clearImage() {
        image = nil
    }
    
    private func cancelImageLoad() {
        imageLoadTask?.cancel()
        imageLoadTask = nil
    }
    
}
