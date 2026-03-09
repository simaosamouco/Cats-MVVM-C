//
//  TestViewController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 01/09/2025.
//

import UIKit
import SwiftUI

final class TestViewController<Content: View>: ThemeHostingController<Content> {
    
    private weak var viewModel: (any TestViewModelProtocol)?
   
    init(view: Content,
         viewModel: some TestViewModelProtocol) {
        super.init(rootView: view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
