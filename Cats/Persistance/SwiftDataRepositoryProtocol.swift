//
//  SwiftDataRepositoryProtocol.swift
//  Cats
//
//  Created by Simão Neves Samouco on 11/09/2025.
//


import SwiftData
import Foundation

protocol SwiftDataRepositoryProtocol {

    /// Fetches all persisted entities of the inferred type.
    /// - Returns: An array of all stored entities. Empty array if none exist.
    func fetch<Entity: PersistentModel>() async throws -> [Entity]

    /// Fetches all persisted entities matching the given predicate.
    /// - Parameter predicate: The condition used to filter entities.
    /// - Returns: An array of matching entities. Empty array if none match.
    func fetch<Entity: PersistentModel>(predicate: Predicate<Entity>) async throws -> [Entity]

    /// Inserts a new entity into the store and saves the context.
    /// - Parameter entity: The entity to persist.
    func insert<Entity: PersistentModel>(_ entity: Entity) async throws

    /// Deletes a specific entity from the store and saves the context.
    /// - Parameter entity: The entity to remove.
    func delete<Entity: PersistentModel>(_ entity: Entity) async throws

    /// Fetches and deletes all entities matching the given predicate, then saves the context.
    /// - Parameter predicate: The condition used to find entities to delete.
    func delete<Entity: PersistentModel>(predicate: Predicate<Entity>) async throws

    /// Checks whether at least one entity matching the predicate exists in the store.
    /// - Parameter predicate: The condition to evaluate.
    /// - Returns: `true` if a match is found, `false` otherwise.
    func exists<Entity: PersistentModel>(predicate: Predicate<Entity>) async throws -> Bool

}

/// A thread-safe, generic SwiftData repository backed by a Swift actor.
///
/// # Why an actor?
/// `ModelContext` is not thread-safe and must never be shared across threads.
/// Using an `actor` guarantees that all operations on the `modelContext` are
/// serialised — only one operation runs at a time, eliminating data races.
///
/// # Why @ModelActor?
/// `@ModelActor` is a macro that:
/// - Creates a custom actor with its own serial background executor (off the main thread)
/// - Automatically synthesises a `modelContext` property owned exclusively by this actor
/// - Automatically synthesises `init(modelContainer:)`, injecting the shared `ModelContainer`
///
/// The result is that all persistence operations run on a background thread automatically,
/// keeping the main thread free for UI work, while Swift's actor isolation ensures
/// no concurrent access to the underlying `ModelContext`.

@ModelActor
actor SwiftDataRepository: SwiftDataRepositoryProtocol {
    
    func fetch<Entity: PersistentModel>() throws -> [Entity] {
        let descriptor = FetchDescriptor<Entity>()
        return try modelContext.fetch(descriptor)
    }
    
    func fetch<Entity: PersistentModel>(predicate: Predicate<Entity>) throws -> [Entity] {
        let descriptor = FetchDescriptor<Entity>(predicate: predicate)
        return try modelContext.fetch(descriptor)
    }
    
    func insert<Entity: PersistentModel>(_ entity: Entity) throws {
        modelContext.insert(entity)
        try modelContext.save()
    }
    
    func delete<Entity: PersistentModel>(_ entity: Entity) throws {
        modelContext.delete(entity)
        try modelContext.save()
    }
    
    func delete<Entity: PersistentModel>(predicate: Predicate<Entity>) throws {
        let results = try fetch(predicate: predicate)
        results.forEach { modelContext.delete($0) }
        try modelContext.save()
    }
    
    func exists<Entity: PersistentModel>(predicate: Predicate<Entity>) throws -> Bool {
        return try !fetch(predicate: predicate).isEmpty
    }
    
}
