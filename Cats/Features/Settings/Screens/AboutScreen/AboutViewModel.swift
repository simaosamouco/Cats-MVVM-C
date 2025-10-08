//
//  AboutViewModel.swift
//  Cats
//
//  Created by Simão Neves Samouco on 30/08/2025.
//

import Foundation

protocol AboutViewModelProtocol: ObservableObject {
    func didTapModalButton()
    func didTapFullScreenModalButton()
    func didTapPushButton()
    func didTapChangeTabButton()
}

final class AboutViewModel: AboutViewModelProtocol {
    
    private let coordinator: AboutViewCoordinatorProtocol
    
    init(coordinator: AboutViewCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func didTapModalButton() {
        coordinator.presentModal()
    }
    
    func didTapFullScreenModalButton() {
        coordinator.presentModalFullscreen()
    }
    
    func didTapPushButton() {
        coordinator.push()
    }
    
    func didTapChangeTabButton() {
        coordinator.changeTab()
    }
    
}
