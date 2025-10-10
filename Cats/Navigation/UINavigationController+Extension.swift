//
//  CoreCoordinatorProtocol.swift
//  Cats
//
//  Created by Simão Neves Samouco on 22/08/2025.
//

import UIKit

extension UINavigationController {
    
    /// popViewController(animated: true)
    func goBack() {
        self.popViewController(animated: true)
    }
    
    /// .pushViewController(viewController, animated: true)
    /// - Parameter viewController: destination `UIViewController`
    func goToScreen(_ viewController: UIViewController, hideTabBar: Bool = false) {
        if hideTabBar {
            viewController.hidesBottomBarWhenPushed = true
        }
        self.pushViewController(viewController, animated: true)
    }
    
    /// .present(viewController, animated: true, completion: nil)
    /// - Parameter viewController: `UIViewController` to be presented
    func presentScreen(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .popover
        self.present(viewController, animated: true, completion: nil)
    }
    
    /// .dismiss(animated: true)
    func dismiss() {
        self.dismiss(animated: true)
    }
    
    /// .popToRootViewController(animated: true)
    func popToRoot() {
        self.popToRootViewController(animated: true)
    }
    
    /// .setViewControllers([viewController], animated: true)
    /// - Parameter viewController: `UIViewController` to set as root
    func setRootViewController(_ viewController: UIViewController) {
        self.setViewControllers([viewController], animated: true)
    }
    
    /// .popToViewController(viewController, animated: animated)
    ///
    /// Checks if a given `UIViewController`  exists in the the navigation stack,
    ///  if it does pops to that `UIViewController`
    ///
    /// - Parameters:
    ///   - type: `UIViewController` type
    ///   - animated: Should animate the pop action
    func popToViewController(ofType type: AnyClass, animated: Bool = true) {
        if let viewController = self.viewControllers.first(where: { $0.isKind(of: type) }) {
            self.popToViewController(viewController, animated: animated)
        }
    }
    
    /// .present(viewController, animated: true, completion: nil)
    ///
    /// Modally presents given `UIViewController` as full screen
    ///
    /// - Parameter viewController: `UIViewController` to be presented modally
    func presentFullscreen(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    /// Attempts to open the specified URL.
    ///
    /// This method first checks whether the system can open the given `URL`.
    /// If it can, the URL is opened using `UIApplication.shared.open`.
    ///
    /// - Parameter url: The `URL` to attempt to open.
    /// - Note: If the URL cannot be opened, this method does nothing.
    func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    /// Presents an alert using the current navigation controller.
    ///
    /// This method creates a `UIAlertController` with the specified title,
    /// message, actions, and preferred style, and then presents it modally.
    /// By default, the alert includes a single **OK** action and uses the
    /// `.alert` style.
    ///
    /// - Parameters:
    ///   - title: The title text to display in the alert. Pass `nil` for no title.
    ///   - message: The message text to display in the alert. Pass `nil` for no message.
    ///   - actions: An array of `UIAlertAction` objects to add to the alert.
    ///              Defaults to a single **OK** action.
    ///   - preferredStyle: The presentation style of the alert controller.
    ///                     Defaults to `.alert`.
    func showAlert(title: String? = "error.alert.defaultTitle".localized,
                   message: String?,
                   actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default, handler: nil)],
                   preferredStyle: UIAlertController.Style = .alert) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for action in actions {
            alertController.addAction(action)
        }

        Task { @MainActor in
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
