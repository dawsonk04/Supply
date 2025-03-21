//
//  ContentView.swift
//  Supply
//
//  Created by Dawson Knudtson on 3/19/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var appStateManager = AppStateManager()
    
    var body: some View {
        if appStateManager.hasCompletedOnboarding {
            MainTabView()
        } else {
            OnboardingView(appStateManager: appStateManager)
        }
    }
}

#Preview {
    ContentView()
}
