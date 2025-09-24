//
//  TemplateView.swift
//  Cats
//
//  Created by Simão Neves Samouco on 23/09/2025.
//

import SwiftUI

struct TemplateView<ViewModel: TemplateViewModelProtocol>: View  {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        Text("TemplateView")
    }
    
}
