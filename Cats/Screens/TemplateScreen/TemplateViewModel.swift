//
//  TemplateViewModel.swift
//  Cats
//
//  Created by Simão Neves Samouco on 23/09/2025.
//

import Foundation

protocol TemplateViewModelProtocol: ObservableObject { }

final class TemplateViewModel: TemplateViewModelProtocol {
    
    private let coordinator: TemplateViewCoordinatorProtocol
    
    init(coordinator: TemplateViewCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
}
