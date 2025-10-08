//
//  ProfileViewController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/08/2025.
//

import UIKit

import SwiftUI
import Combine

class ProfileViewController: UIViewController {
    
    private let viewModel: any ProfileViewModelProtocol
    
    private var barButton: UIBarButtonItem!
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: any ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwiftUIView()
        setupNavigationBar()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.checkCatSavedStatus()
    }
    
    /// Adds trailing item to `Navigation Bar`
    private func setupNavigationBar() {
        barButton = UIBarButtonItem(
            image: UIImage(systemName: "bookmark"),
            style: .plain,
            target: self,
            action: #selector(saveButtonTapped)
        )
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func saveButtonTapped() {
        viewModel.didTapSaveButton()
    }
    
    /// Subscribes to the view model’s `isCatSavedPublisher` and updates
    /// the navigation bar item’s image to show the cat’s saved state
    /// (`bookmark.fill` when saved, `bookmark` when not).
    private func bindViewModel() {
        viewModel.isCatSavedPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] isSaved in
                let imageName = isSaved ? "bookmark.fill" : "bookmark"
                self?.barButton.image = UIImage(systemName: imageName)
            }
            .store(in: &cancellables)
    }

    private func addSwiftUIView() {
        guard let viewModel = viewModel as? ProfileViewModel else { return }
        let swiftUIView = ProfileView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: swiftUIView)

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
