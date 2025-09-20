//
//  PersistantModel.swift
//  Cats
//
//  Created by Simão Neves Samouco on 13/09/2025.
//


import Foundation
import SwiftData

/// An enumeration used to register all `@Model` types into the
/// `SwiftData` `ModelContainer` schema.
///
/// Each case represents a specific model type that should be included
/// in the app’s persistent storage schema.
///
/// When adding a new SwiftData `@Model` in the project, create a new
/// case in this enum and return the model’s type in the `type` property.
/// This ensures that the model is automatically registered into the schema
/// at runtime, keeping schema management centralized and consistent.
///
/// Example:
/// ```swift
/// case dog
///
/// var type: any PersistentModel.Type {
///     switch self {
///     case .cat: return CatSwiftData.self
///     case .dog: return DogSwiftData.self
///     }
/// }
/// ```
enum PersistantModel: CaseIterable {
    
    case cat
    
    /// The associated SwiftData `@Model` type to be registered.
    var type: any PersistentModel.Type {
        switch self {
        case .cat:
            return CatSwiftData.self
        }
    }
}
