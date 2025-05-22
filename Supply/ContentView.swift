//
//  ContentView.swift
//  Supply
//
//  Created by Dawson Knudtson on 3/19/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: SupplyViewModel
    
    var body: some View {
        OnboardingView()
    }
}

#Preview {
    ContentView()
        .environmentObject(SupplyViewModel())
}
