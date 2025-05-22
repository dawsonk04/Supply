//
//  ContentView.swift
//  Supply
//
//  Created by Dawson Knudtson on 3/19/25.
//

import SwiftUI

enum NavigationDestination {
    case signup
    case login
    case main
}

struct ContentView: View {
    @EnvironmentObject var viewModel: SupplyViewModel
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            OnboardingView(navigationPath: $navigationPath)
                .navigationDestination(for: NavigationDestination.self) { destination in
                    switch destination {
                    case .signup:
                        SignupView()
                    case .login:
                        LoginView()
                    case .main:
                        MainView()
                    }
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(SupplyViewModel())
}
