//
//  ThemeHostingController.swift
//  Cats
//
//  Created by Simão Neves Samouco on 09/03/2026.
//

import SwiftUI

class ThemeHostingController<Content: View>: UIHostingController<Content> {
    
    var hidesNavigationBarWhenPushed = false
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(
            hidesNavigationBarWhenPushed,
            animated: false
        )
    }
    
}
