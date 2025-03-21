import SwiftUI

struct RecommendationsView: View {
    @EnvironmentObject var viewModel: SupplyViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(1.5)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            recommendationsContent
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Recommendations")
            .navigationBarTitleDisplayMode(.large)
            .foregroundColor(.white)
        }
    }
    
    private var recommendationsContent: some View {
        VStack(spacing: 20) {
            ForEach(viewModel.recommendedSupplements) { supplement in
                recommendationCard(supplement)
            }
        }
    }
    
    private func recommendationCard(_ supplement: Supplement) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text(supplement.name)
                    .font(.title3)
                    .bold()
                
                Spacer()
                
                Text(supplement.category.rawValue)
                    .font(.subheadline)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(8)
            }
            
            Text(supplement.description)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Benefits:")
                    .font(.headline)
                
                ForEach(supplement.benefits, id: \.self) { benefit in
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text(benefit)
                            .foregroundColor(.gray)
                    }
                }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Dosage")
                        .font(.subheadline)
                    Text(supplement.dosage)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Frequency")
                        .font(.subheadline)
                    Text(supplement.frequency)
                        .foregroundColor(.gray)
                }
            }
            
            Button(action: {
                viewModel.addSupplement(supplement)
            }) {
                Text("Add to My Supplements")
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
}

#Preview {
    RecommendationsView()
        .environmentObject(SupplyViewModel())
} 