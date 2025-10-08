//
//  Screens.swift
//  Cats
//
//  Created by Simão Neves Samouco on 01/08/2025.
//

import UIKit

/// `TabBarScreen` is responsible for defining and resolving the content of the Tab Bar.
/// It is fully self-contained, meaning each case knows everything required to configure
/// its corresponding tab: index, title, image, and view controller.
/// This design ensures that when configuring the Tab Bar Controller, no external changes
/// (such as manually setting indices, titles, or images) are needed.
/// Adding a new tab is seamless—by extending this enum and providing the required properties
/// and `makeViewController` implementation, the Tab Bar can automatically resolve itself.
enum TabBarScreen: CaseIterable {
    
    case catsList
    case savedCats
    case settings

    /// This value will reflect the order of the view controllers in the `TabBar`
    var index: Int {
        switch self {
        case .catsList: return 0
        case .savedCats: return 1
        case .settings: return 2
        }
    }
    
    /// TabBar Item title
    var title: String {
        switch self {
        case .catsList: return "catsList.title".localized
        case .savedCats: return "savedCats.title".localized
        case .settings: return "settings.title".localized
        }
    }
    
    /// TabBar Item image
    var image: UIImage {
        switch self {
        case .catsList:
            return UIImage(systemName: "house")!
        case .savedCats:
            return UIImage(systemName: "square.and.arrow.down")!
        case .settings:
            return UIImage(systemName: "gear")!
        }
    }
    
    /// Returns a `UIViewController` for each case in the enum.
    /// Updated to use the concrete Factory class that implements all specific factory protocols
    func makeViewController(factory: Factory,
                            navController: UINavigationController) -> UIViewController? {
        switch self {
        case .catsList:
            return factory.createCatsListController(navController: navController)
        case .savedCats:
            return factory.createSavedCatsViewController(navController: navController)
        case .settings:
            return factory.createSettingsViewController(navController: navController)
        }
    }
    
}
