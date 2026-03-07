//
//  AboutViewController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 30/08/2025.
//

import UIKit
import SwiftUI

final class AboutViewController: UIViewController {
    
    private let viewModel: any AboutViewModelProtocol
    
    init(viewModel: any AboutViewModelProtocol) {
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
        guard let viewModel = viewModel as? AboutViewModel else { return }
        let AboutView = AboutView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: AboutView)

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
