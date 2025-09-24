//
//  TemplateViewController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 23/09/2025.
//

import UIKit
import SwiftUI

final class TemplateViewController: UIViewController {
    
    private let viewModel: any TemplateViewModelProtocol
    
    init(viewModel: any TemplateViewModelProtocol) {
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
        guard let viewModel = viewModel as? TemplateViewModel else { return }
        let TemplateView = TemplateView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: TemplateView)

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
//  func createTemplateViewController(navController: UINavigationController) -> TemplateViewController {
//      let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
//                                    argument: navController)
//      let tabBarCoordinator = resolve(TabBarCoordinatorProtocol.self)
//      return TemplateViewController(
//          viewModel: TemplateViewModel(
//              coordinator: TemplateViewCoordinator(
//                  factory: self,
//                  coreCoordinator: coreCoordinator
//              )
//          )
//      )
//  }
