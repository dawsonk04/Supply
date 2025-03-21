//
//  SupplyApp.swift
//  Supply
//
//  Created by Dawson Knudtson on 3/19/25.
//

import SwiftUI

@main
struct SupplyApp: App {
    @StateObject private var appStateManager = AppStateManager()
    
    var body: some Scene {
        WindowGroup {
            if appStateManager.hasCompletedOnboarding {
                MainTabView()
            } else {
                OnboardingView(appStateManager: appStateManager)
            }
        }
    }
}
