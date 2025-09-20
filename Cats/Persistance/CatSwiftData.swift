//
//  CatSwiftData.swift
//  Cats
//
//  Created by Simão Neves Samouco on 07/08/2025.
//

import Foundation
import SwiftData

@Model
final class CatSwiftData {
    
    var id: String
    var url: String
    var breedName: String
    var breedDescription: String
    
    init(id: String,
         url: String,
         breedName: String,
         breedDescription: String) {
        self.id = id
        self.url = url
        self.breedName = breedName
        self.breedDescription = breedDescription
    }
    
}

// MARK: - DomainModelConvertible
extension CatSwiftData: DomainModelConvertible {
    
    typealias DomainModel = Cat
    
    /// Converts `CatSwiftData` into `Cat`
    func toDomainModel() -> Cat? {
        Cat(
            id: id,
            url: self.url,
            breedName: self.breedName,
            breedDescription: self.breedDescription
        )
    }
    
}
