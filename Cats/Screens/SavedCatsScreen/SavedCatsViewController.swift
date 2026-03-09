//
//  SavedCatsViewController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 19/09/2025.
//

import UIKit
import SwiftUI

final class SavedCatsViewController<Content: View>: ThemeHostingController<Content>  {
    
    private weak var viewModel: (any SavedCatsViewModelProtocol)?
   
    init(view: Content,
         viewModel: some SavedCatsViewModelProtocol) {
        super.init(rootView: view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
