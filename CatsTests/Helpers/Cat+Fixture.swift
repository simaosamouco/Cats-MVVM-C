//
//  Cat+Fixture.swift
//  CatsTests
//

import Foundation
@testable import Cats

extension Cat {

    /// Creates a `Cat` instance with sensible defaults for use in tests.
    static func fixture(
        id: String = "fixture-id",
        url: String = "https://example.com/cat.jpg",
        breedName: String = "Test Breed",
        breedDescription: String = "A test breed description"
    ) -> Cat {
        Cat(id: id, url: url, breedName: breedName, breedDescription: breedDescription)
    }
}
