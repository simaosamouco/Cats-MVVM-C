//
//  TestViewModel.swift
//  DogsTest
//
//  Created by Simão Neves Samouco on 01/09/2025.
//

import Foundation

protocol TestViewModelProtocol: ObservableObject {
    func didTapButton()
}

final class TestViewModel: TestViewModelProtocol {
    
    private let coordinator: TestViewCoordinatorProtocol
    private let isModallyPresented: Bool
    
    init(coordinator: TestViewCoordinatorProtocol,
         isModallyPresented: Bool) {
        self.coordinator = coordinator
        self.isModallyPresented = isModallyPresented
    }
    
    func didTapButton() {
        coordinator.goBack(isModallyPresented)
    }
    
}
