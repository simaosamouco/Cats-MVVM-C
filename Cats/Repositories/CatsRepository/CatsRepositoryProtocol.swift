//
//  CatsRepositoryProtocol.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/03/2026.
//

protocol CatsFetchRepositoryProtocol {
    /// Fetches a page of cats from the underlying data source.
    ///
    /// - Parameter page: The 1-based page index to fetch.
    /// - Returns: An array of `Cat` models for the requested page.
    func get(for page: Int) async throws -> [Cat]
}

protocol CatsPersistenceRepositoryProtocol {
    /// Persists the given cat to the local data store.
    /// - Parameter cat: The `Cat` domain model to save.
    func saveCat(_ cat: Cat) async throws
    
    /// Removes the given cat from the local data store.
    /// - Parameter cat: The `Cat` domain model to delete.
    /// - Throws: An error if no matching cat is found or the delete operation fails.
    func deleteCat(_ cat: Cat) async throws
    
    /// Returns whether the given cat is currently saved in the local data store.
    /// - Parameter cat: The `Cat` domain model to check.
    /// - Returns: `true` if the cat exists in the store, `false` otherwise.
    func isCatSaved(_ cat: Cat) async throws -> Bool
}

/// A protocol that composes `CatsFetchRepositoryProtocol` and `CatsPersistenceRepositoryProtocol`
/// into a single interface, following the Interface Segregation Principle.
///
/// Rather than exposing all repository capabilities to every consumer,
/// each use case depends only on the protocol that matches its needs:
/// - `GetCatsUseCase` depends on `CatsFetchRepositoryProtocol`
/// - `CatSaveUseCase` depends on `CatsPersistenceRepositoryProtocol`
///
/// In both cases, the same `LocalCatsRepository` instance is injected at runtime,
/// but each consumer only has visibility into the methods it actually requires.
protocol LocalCatsRepositoryProtocol: CatsFetchRepositoryProtocol,
                                      CatsPersistenceRepositoryProtocol { }
