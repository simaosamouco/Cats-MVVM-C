//
//  ProfileViewController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 08/08/2025.
//

import SwiftUI

class ProfileViewController<Content: View>: ThemeHostingController<Content> {
 
    private weak var viewModel: (any ProfileViewModelProtocol)?

    init(view: Content,
         viewModel: some ProfileViewModelProtocol) {
        super.init(rootView: view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
