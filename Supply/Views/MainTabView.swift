import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = SupplyViewModel()
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Today", systemImage: "house.fill")
                }
            
            RecommendationsView()
                .tabItem {
                    Label("Recommendations", systemImage: "star.fill")
                }
            
            LogView()
                .tabItem {
                    Label("Log", systemImage: "checklist")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    MainTabView()
} 