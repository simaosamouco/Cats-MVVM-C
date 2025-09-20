//
//  TestViewController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 01/09/2025.
//

import UIKit
import SwiftUI

final class TestViewController: UIViewController {
    
    private let viewModel: any TestViewModelProtocol
    
    init(viewModel: any TestViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwiftUIView()
    }
    
    private func addSwiftUIView() {
        guard let viewModel = viewModel as? TestViewModel else { return }
        let TestView = TestView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: TestView)

        addChild(hostingController)
        view.addSubview(hostingController.view)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        hostingController.didMove(toParent: self)
    }
    
}

//  SCREEN FACTORY METHOD:
//
//  func createTestViewController(navController: UINavigationController) -> TestViewController {
//      let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
//                                    argument: navController)
//      let tabBarCoordinator = resolve(TabBarCoordinatorProtocol.self)
//      return TestViewController(
//          viewModel: TestViewModel(
//              coordinator: TestViewCoordinator(
//                  factory: self,
//                  coreCoordinator: coreCoordinator
//              )
//          )
//      )
//  }
