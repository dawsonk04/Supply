//
//  SupplyApp.swift
//  Supply
//
//  Created by Dawson Knudtson on 3/19/25.
//

import SwiftUI

@main
struct SupplyApp: App {
    @StateObject private var viewModel = SupplyViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
