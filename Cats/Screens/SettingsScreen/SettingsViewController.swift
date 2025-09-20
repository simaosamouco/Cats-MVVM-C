//
//  SettingsViewController.swift
//  DogsTest
//
//  Created by Simão Neves Samouco on 28/08/2025.
//

import UIKit
import SwiftUI

class SettingsViewController: UIViewController {
    
    private let viewModel: any SettingsViewModelProtocol
    
    init(viewModel: any SettingsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSwiftUIView()
        self.title = "settings.title".localized
    }
    
    private func addSwiftUIView() {
        guard let viewModel = viewModel as? SettingsViewModel else { return }
        let swiftUIView = SettingsView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: swiftUIView)

        // Add as child VC
        addChild(hostingController)
        view.addSubview(hostingController.view)

        // Set layout
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
