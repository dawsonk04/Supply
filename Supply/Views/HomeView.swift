import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: SupplyViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                GradientBackground()
                
                ScrollView {
                    VStack(spacing: 25) {
                        todayProgress
                        currentSupplements
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
            }
            .navigationTitle("Today")
            .navigationBarTitleDisplayMode(.large)
            .foregroundColor(.white)
        }
    }
    
    private var todayProgress: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 20) {
                Text("Today's Progress")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                let takenCount = viewModel.currentUser.supplements.filter { $0.isTaken }.count
                let totalCount = viewModel.currentUser.supplements.count
                
                HStack {
                    Text("\(takenCount)/\(totalCount)")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("\(Int((Double(takenCount) / Double(totalCount)) * 100))%")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                
                ProgressView(value: Double(takenCount), total: Double(totalCount))
                    .tint(.white)
                    .frame(height: 8)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(4)
            }
        }
    }
    
    private var currentSupplements: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 20) {
                Text("Today's Supplements")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                if viewModel.currentUser.supplements.isEmpty {
                    Text("No supplements added yet")
                        .foregroundColor(.white.opacity(0.7))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 30)
                } else {
                    ForEach(viewModel.currentUser.supplements) { supplement in
                        supplementRow(supplement)
                    }
                }
            }
        }
    }
    
    private func supplementRow(_ supplement: Supplement) -> some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 4) {
                Text(supplement.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text("\(supplement.dosage) - \(supplement.frequency)")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
            
            Button(action: {
                viewModel.toggleSupplementTaken(supplement)
            }) {
                Image(systemName: supplement.isTaken ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(supplement.isTaken ? .green : .white.opacity(0.7))
                    .font(.title2)
            }
        }
        .padding(.vertical, 12)
    }
}

#Preview {
    HomeView()
        .environmentObject(SupplyViewModel())
} 