//
//  AboutViewController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 30/08/2025.
//

import SwiftUI

final class AboutViewController<Content: View>: ThemeHostingController<Content> {
    
    private weak var viewModel: (any AboutViewModelProtocol)?
    
    init(view: Content,
         viewModel: some AboutViewModelProtocol) {
        super.init(rootView: view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
