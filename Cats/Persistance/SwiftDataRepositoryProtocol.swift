//
//  SwiftDataRepositoryProtocol.swift
//  Cats
//
//  Created by Simão Neves Samouco on 11/09/2025.
//


import SwiftData
import Foundation

// MARK: - Generic Repository Protocol
protocol SwiftDataRepositoryProtocol {
    func fetch<Entity: PersistentModel>() async throws -> [Entity]
    func fetch<Entity: PersistentModel>(predicate: Predicate<Entity>) async throws -> [Entity]
    func insert<Entity: PersistentModel>(_ entity: Entity) async throws
    func delete<Entity: PersistentModel>(_ entity: Entity) async throws
    func delete<Entity: PersistentModel>(predicate: Predicate<Entity>) async throws
    func save() async throws
    func exists<Entity: PersistentModel>(predicate: Predicate<Entity>) async throws -> Bool
}

// MARK: - Generic Repository Implementation
final class SwiftDataRepository: SwiftDataRepositoryProtocol {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetch<Entity: PersistentModel>() async throws -> [Entity] {
        let descriptor = FetchDescriptor<Entity>()
        return try modelContext.fetch(descriptor)
    }
    
    func fetch<Entity: PersistentModel>(predicate: Predicate<Entity>) async throws -> [Entity] {
        let descriptor = FetchDescriptor<Entity>(predicate: predicate)
        return try modelContext.fetch(descriptor)
    }
    
    func insert<Entity: PersistentModel>(_ entity: Entity) async throws {
        modelContext.insert(entity)
        try await save()
    }
    
    func delete<Entity: PersistentModel>(_ entity: Entity) async throws {
        modelContext.delete(entity)
        try await save()
    }
    
    func delete<Entity: PersistentModel>(predicate: Predicate<Entity>) async throws {
        let results = try await fetch(predicate: predicate)
        for entity in results {
            modelContext.delete(entity)
        }
        try await save()
    }
    
    func save() async throws {
        try modelContext.save()
    }
    
    func exists<Entity: PersistentModel>(predicate: Predicate<Entity>) async throws -> Bool {
        let results = try await fetch(predicate: predicate)
        return !results.isEmpty
    }
    
}
