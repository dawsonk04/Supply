import SwiftUI

struct GradientBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.85, green: 0.95, blue: 1.0),  // Light baby blue
                Color(red: 0.75, green: 0.90, blue: 1.0)   // Slightly darker baby blue
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

#Preview {
    GradientBackground()
} 
