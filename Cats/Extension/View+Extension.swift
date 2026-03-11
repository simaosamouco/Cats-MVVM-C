//
//  View+Extension.swift
//  Cats
//
//  Created by Simão Neves Samouco on 11/03/2026.
//

import SwiftUI

extension View {

    func onFirstAppear(perform action: @escaping () -> Void) -> some View {
        modifier(OnFirstAppearModifier(action: action))
    }

}
