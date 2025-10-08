//
//  TestView.swift
//  Cats
//
//  Created by Simão Neves Samouco on 01/09/2025.
//

import SwiftUI

struct TestView<ViewModel: TestViewModelProtocol>: View  {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: Measures.Spacing.wide) {
            Text("Test Screen")
                .font(.title)
            
            Button("Back") {
                viewModel.didTapButton()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
