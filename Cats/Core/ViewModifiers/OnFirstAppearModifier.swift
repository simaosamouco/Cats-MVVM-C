//
//  ViewDidLoadModifier.swift
//  Cats
//
//  Created by Simão Neves Samouco on 11/03/2026.
//

import SwiftUI

struct OnFirstAppearModifier: ViewModifier {
    
    @State private var hasAppeared = false
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            action()
        }
    }
    
}
 
