//
//  ContentView.swift
//  Supply
//
//  Created by Dawson Knudtson on 3/19/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var viewModel: SupplyViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.currentUser.name.isEmpty {
                OnboardingView()
            } else {
                MainTabView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(SupplyViewModel())
}
