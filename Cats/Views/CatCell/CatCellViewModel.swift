//
//  CatCellViewModel.swift
//  DogsTest
//
//  Created by Simão Neves Samouco on 07/08/2025.
//

import SwiftUI

protocol CatCellViewModelProtocol: ObservableObject {
    var image: UIImage? { get }
    var breedName: String { get }
    var id: String { get }
    
    func loadImage()
}

final class CatCellViewModel: CatCellViewModelProtocol {
    
    @Published var image: UIImage?
    let breedName: String
    let url: String
    let id: String
    
    private let getImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol
    
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
        Task { @MainActor in
            self.image = await getImageFromUrlUseCase.get(from: url)
        }
    }
    
}
