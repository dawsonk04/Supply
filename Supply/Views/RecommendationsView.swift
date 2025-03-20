import SwiftUI

struct RecommendationsView: View {
    @EnvironmentObject private var viewModel: SupplyViewModel
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                } else if viewModel.recommendedSupplements.isEmpty {
                    Text("No recommendations available")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(viewModel.recommendedSupplements) { supplement in
                        RecommendationRow(supplement: supplement)
                    }
                }
            }
            .navigationTitle("Recommendations")
            .refreshable {
                viewModel.loadRecommendedSupplements()
            }
        }
    }
}

struct RecommendationRow: View {
    @EnvironmentObject private var viewModel: SupplyViewModel
    let supplement: Supplement
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(supplement.name)
                .font(.headline)
            
            Text(supplement.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("Benefits:")
                .font(.subheadline)
                .fontWeight(.medium)
            
            ForEach(supplement.benefits, id: \.self) { benefit in
                Text("• \(benefit)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Text("Dosage: \(supplement.dosage)")
                Spacer()
                Text("Frequency: \(supplement.frequency)")
            }
            .font(.caption)
            .foregroundColor(.secondary)
            
            Button(action: {
                viewModel.addSupplement(supplement)
            }) {
                Text("Add to My Supplements")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    RecommendationsView()
        .environmentObject(SupplyViewModel())
} 