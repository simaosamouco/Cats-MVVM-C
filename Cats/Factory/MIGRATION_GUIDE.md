//
//  MIGRATION_GUIDE.md
//  Cats Factory Architecture Refactoring
//
//  Created by Simão Neves Samouco on 08/10/2025.
//

# Factory Architecture Migration Guide

## Overview
The factory system has been refactored to solve the scaling issues with the monolithic `Factory` class. The new architecture separates concerns and makes the system more modular and maintainable.

## New Architecture Components

### 1. DependencyContainer
- **Purpose**: Centralized dependency injection container
- **Responsibilities**: 
  - Register and resolve dependencies
  - Manage object lifecycles (lazy, factory, singleton)
- **File**: `DependencyContainer.swift`

### 2. Feature Factories
- **Purpose**: Self-contained factories for each feature
- **Files**: 
  - `CatsFeatureFactory.swift`
  - `SettingsFeatureFactory.swift` 
  - `TestFeatureFactory.swift`
- **Benefits**: Each factory handles its own view controller creation logic

### 3. AppFactory (Composition Root)
- **Purpose**: Main factory that orchestrates the entire system
- **Responsibilities**:
  - Initialize dependency container
  - Initialize feature factories
  - Provide access to feature factories
  - Maintain backward compatibility during migration
- **File**: `AppFactory.swift`

## Migration Steps

### Step 1: Update App Initialization
Replace the old Factory initialization:

```swift
// OLD
let factory = Factory()
let tabBarController = factory.createTabBarController()

// NEW
let appFactory = AppFactory()
let tabBarController = appFactory.createTabBarController()
```

### Step 2: Update Route Factories
Route factories now receive specific feature factories instead of the monolithic factory:

```swift
// OLD
let catsRouteFactory = CatsRouteFactory(catsFactory: factory)

// NEW
let catsRouteFactory = CatsRouteFactory(catsFactory: appFactory.cats)
```

### Step 3: Update Coordinators (if needed)
If coordinators reference the main factory, update them to use feature-specific factories:

```swift
// OLD
class SomeCoordinator {
    private let factory: Factory
    
    init(factory: Factory) {
        self.factory = factory
    }
}

// NEW
class SomeCoordinator {
    private let catsFactory: CatsViewControllerFactoryProtocol
    
    init(catsFactory: CatsViewControllerFactoryProtocol) {
        self.catsFactory = catsFactory
    }
}
```

### Step 4: Clean Up Old Files
Once migration is complete, remove these files:
- `Factory.swift`
- `Factory+DependencyInjection.swift`
- `Factory+Registration.swift`

## Benefits of New Architecture

1. **Separation of Concerns**: 
   - Dependency injection is separate from view controller creation
   - Each feature manages its own factory logic

2. **Scalability**: 
   - Adding new features doesn't bloat the main factory
   - Feature factories can be developed independently

3. **Testability**: 
   - Feature factories can be tested in isolation
   - Easier to mock dependencies for specific features

4. **Maintainability**: 
   - Smaller, focused classes
   - Clear ownership of responsibilities

5. **Flexibility**: 
   - Can easily swap feature implementations
   - Better support for feature flags and A/B testing

## Usage Examples

### Creating a New Feature Factory
```swift
final class NewFeatureFactory: NewFeatureFactoryProtocol {
    
    private let container: DependenciesResolverProtocol
    
    init(container: DependenciesResolverProtocol) {
        self.container = container
    }
    
    func createNewViewController(navController: UINavigationController) -> NewViewController {
        let dependencies = container.resolve(SomeServiceProtocol.self)
        return NewViewController(dependencies: dependencies)
    }
}
```

### Accessing Feature Factories
```swift
// Through AppFactory
let appFactory = AppFactory()

// Access specific feature factories
let catsController = appFactory.cats.createCatsListController(navController: navController)
let settingsController = appFactory.settings.createSettingsViewController(navController: navController)

// Or use backward-compatible methods
let catsController = appFactory.createCatsListController(navController: navController)
```

## Troubleshooting

### Common Issues During Migration

1. **Compilation Errors**: Make sure to update all references from `Factory` to `AppFactory`
2. **Missing Dependencies**: Ensure all dependencies are registered in `DependencyContainer`
3. **Circular Dependencies**: Feature factories should not depend on each other directly

### Testing the New System

Create unit tests for each feature factory:
```swift
import Testing

@Suite("Cats Feature Factory Tests")
struct CatsFeatureFactoryTests {
    
    @Test("Creates cats list controller successfully")
    func createCatsListController() {
        // Setup
        let mockContainer = MockDependencyContainer()
        let factory = CatsFeatureFactory(container: mockContainer)
        let navController = UINavigationController()
        
        // Act
        let controller = factory.createCatsListController(navController: navController)
        
        // Assert
        #expect(controller != nil)
        #expect(type(of: controller) == CatsListViewController.self)
    }
}
```

## Next Steps

1. Update app initialization to use `AppFactory`
2. Update all route factory initializations
3. Test the new system thoroughly
4. Remove deprecated files once migration is confirmed working
5. Consider adding feature flags to gradually roll out new features using the modular system