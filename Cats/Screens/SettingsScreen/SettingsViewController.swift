//
//  SettingsViewController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 28/08/2025.
//

import UIKit
import SwiftUI

class SettingsViewController<Content: View>: ThemeHostingController<Content> {
    
    private weak var viewModel: (any SettingsViewModelProtocol)?

    init(view: Content,
         viewModel: some SettingsViewModelProtocol) {
        super.init(rootView: view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
