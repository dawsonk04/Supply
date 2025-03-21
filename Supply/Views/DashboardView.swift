import SwiftUI

struct DashboardView: View {
    let supplements: String
    let height: String
    let weight: String
    let gender: String
    let goals: Set<String>
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    welcomeSection
                    currentSupplementsSection
                    recommendationsSection
                    goalsSection
                }
                .padding()
            }
        }
    }
    
    private var welcomeSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Welcome!")
                .font(.largeTitle)
                .foregroundColor(.white)
            
            Text("Based on your profile:")
                .font(.headline)
                .foregroundColor(.gray)
            
            HStack(spacing: 20) {
                statsCard(title: "Height", value: height)
                statsCard(title: "Weight", value: weight)
                statsCard(title: "Gender", value: gender)
            }
        }
    }
    
    private func statsCard(title: String, value: String) -> some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
    }
    
    private var currentSupplementsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Current Supplements")
                .font(.title2)
                .foregroundColor(.white)
            
            Text(supplements.isEmpty ? "No supplements listed" : supplements)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
        }
    }
    
    private var recommendationsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recommended for You")
                .font(.title2)
                .foregroundColor(.white)
            
            // Example recommendations based on goals
            ForEach(Array(goals), id: \.self) { goal in
                recommendationCard(for: goal)
            }
        }
    }
    
    private func recommendationCard(for goal: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(goal)
                .font(.headline)
                .foregroundColor(.white)
            
            // Example recommendations (you would replace these with real recommendations)
            Text(getRecommendation(for: goal))
                .foregroundColor(.gray)
            
            Button(action: {
                // Handle learning more about recommendations
            }) {
                Text("Learn More")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
    }
    
    private var goalsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Your Goals")
                .font(.title2)
                .foregroundColor(.white)
            
            ForEach(Array(goals), id: \.self) { goal in
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                    Text(goal)
                }
                .foregroundColor(.white)
            }
        }
    }
    
    private func getRecommendation(for goal: String) -> String {
        switch goal {
        case "Build Muscle":
            return "Protein supplements, Creatine, BCAAs"
        case "Happier Lifestyle":
            return "Vitamin D, Omega-3, B-Complex"
        case "Cognitive Clarity":
            return "Lion's Mane, Bacopa, Ginkgo Biloba"
        case "Performance":
            return "Pre-workout, Beta-Alanine, Caffeine"
        case "Better Sleep":
            return "Magnesium, Melatonin, L-Theanine"
        case "More Focus":
            return "Alpha GPC, L-Tyrosine, Rhodiola"
        default:
            return "Custom recommendations coming soon"
        }
    }
}

#Preview {
    DashboardView(
        supplements: "Protein, Creatine",
        height: "6'0\"",
        weight: "180",
        gender: "Male",
        goals: ["Build Muscle", "Better Sleep"]
    )
} 