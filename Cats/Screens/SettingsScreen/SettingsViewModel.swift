//
//  SettingsViewModel.swift
//  DogsTest
//
//  Created by Simão Neves Samouco on 28/08/2025.
//

import UIKit

protocol SettingsViewModelProtocol: ObservableObject {
    
    var selectedTheme: Theme { get set }
    
    func didSwitchTheme(to theme: Theme)
    func didTapAboutRow()
}

final class SettingsViewModel: SettingsViewModelProtocol {
    
    private let coordinator: SettingsCoordinatorProtocol
    private let appThemeUseCase: AppThemeUseCaseProtocol
    
    @Published var selectedTheme: Theme = .system
    
    init(coordinator: SettingsCoordinatorProtocol,
         appThemeUseCase: AppThemeUseCaseProtocol) {
        self.coordinator = coordinator
        self.appThemeUseCase = appThemeUseCase
        selectedTheme = appThemeUseCase.getCurrentTheme()
    }
    
    func didSwitchTheme(to theme: Theme) {
        appThemeUseCase.switchTheme(to: theme)
    }
    
    func didTapAboutRow() {
        coordinator.goToAboutScreen()
    }
    
}
