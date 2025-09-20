//
//  CatsListViewController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 19/09/2025.
//

import UIKit
import SwiftUI

final class CatsListViewController: UIViewController {
    
    private let viewModel: any CatsListViewModelProtocol

    init(viewModel: any CatsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .systemBackground
        // Allow content to extend under bars
        self.edgesForExtendedLayout = [.top, .bottom]
        self.extendedLayoutIncludesOpaqueBars = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSwiftUIView()
        viewModel.getCats(for: .initial)
        self.title = "catsList.title".localized
    }

    private func addSwiftUIView() {
        guard let viewModel = viewModel as? CatsListViewModel else { return }
        let swiftUIView = CatsListView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: swiftUIView)

        addChild(hostingController)
        view.addSubview(hostingController.view)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            hostingController.view.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            hostingController.view.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            hostingController.view.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
        ])

        hostingController.didMove(toParent: self)
    }
}

//  SCREEN FACTORY METHOD:
//
//  func createCatsListViewController(navController: UINavigationController) -> CatsListViewController {
//      let coreCoordinator = resolve(CoreCoordinatorProtocol.self,
//                                    argument: navController)
//      let tabBarCoordinator = resolve(TabBarCoordinatorProtocol.self)
//      return CatsListViewController(
//          viewModel: CatsListViewModel(
//              coordinator: CatsListViewCoordinator(
//                  factory: self,
//                  coreCoordinator: coreCoordinator
//              )
//          )
//      )
//  }
