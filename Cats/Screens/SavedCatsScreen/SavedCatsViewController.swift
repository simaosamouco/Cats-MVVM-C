//
//  SavedCatsViewController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 19/09/2025.
//

import UIKit
import SwiftUI

final class SavedCatsViewController: UIViewController {
    
    private let viewModel: any SavedCatsViewModelProtocol
    
    init(viewModel: any SavedCatsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwiftUIView()
        self.title = "savedCats.title".localized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Ensure cats are loaded when the view appears
        // This is a backup in case SwiftUI's onAppear doesn't trigger
        viewModel.getSavedCats()
    }
    
    private func addSwiftUIView() {
        guard let viewModel = viewModel as? SavedCatsViewModel else { return }
        let SavedCatsView = SavedCatsView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: SavedCatsView)

        addChild(hostingController)
        view.addSubview(hostingController.view)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        hostingController.didMove(toParent: self)
    }
    
}

//  SCREEN FACTORY METHOD:
//
//  func createSavedCatsViewController(navController: UINavigationController) -> SavedCatsViewController {
//      let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
//                                    argument: navController)
//      let tabBarCoordinator = resolve(TabBarCoordinatorProtocol.self)
//      return SavedCatsViewController(
//          viewModel: SavedCatsViewModel(
//              coordinator: SavedCatsViewCoordinator(
//                  factory: self,
//                  coreCoordinator: coreCoordinator
//              )
//          )
//      )
//  }
