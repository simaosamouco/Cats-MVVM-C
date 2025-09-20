//
//  Cat.swift
//  DogsTest
//
//  Created by Simão Neves Samouco on 06/08/2025.
//

import Foundation

struct Cat {
    
    let id: String
    let url: String
    let breedName: String
    let breedDescription: String
    
}

extension Cat: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id, url, breeds
    }
    
    private struct Breed: Decodable {
        let name: String
        let description: String
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.url = try container.decode(String.self, forKey: .url)
        let breeds = try container.decodeIfPresent([Breed].self, forKey: .breeds)
        self.breedName = breeds?.first?.name ?? "Unknown"
        self.breedDescription = breeds?.first?.description ?? "Unknown"
    }
}

extension Cat {
    func toCatProfile() -> CatProfileModel {
        return CatProfileModel(
            id: self.id,
            breedName: self.breedName,
            breedDescription: self.breedDescription,
            url: self.url
        )
    }
}
