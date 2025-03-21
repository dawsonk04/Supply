import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: SupplyViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        todayProgress
                        currentSupplements
                    }
                    .padding()
                }
            }
            .navigationTitle("Today")
            .navigationBarTitleDisplayMode(.large)
            .foregroundColor(.white)
        }
    }
    
    private var todayProgress: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Today's Progress")
                .font(.title2)
                .foregroundColor(.white)
            
            let takenCount = viewModel.currentUser.supplements.filter { $0.isTaken }.count
            let totalCount = viewModel.currentUser.supplements.count
            
            HStack {
                Text("\(takenCount)/\(totalCount)")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(Int((Double(takenCount) / Double(totalCount)) * 100))%")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            ProgressView(value: Double(takenCount), total: Double(totalCount))
                .tint(.white)
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
    }
    
    private var currentSupplements: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Today's Supplements")
                .font(.title2)
                .foregroundColor(.white)
            
            if viewModel.currentUser.supplements.isEmpty {
                Text("No supplements added yet")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ForEach(viewModel.currentUser.supplements) { supplement in
                    supplementRow(supplement)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
    }
    
    private func supplementRow(_ supplement: Supplement) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(supplement.name)
                    .font(.headline)
                Text("\(supplement.dosage) - \(supplement.frequency)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: {
                viewModel.toggleSupplementTaken(supplement)
            }) {
                Image(systemName: supplement.isTaken ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(supplement.isTaken ? .green : .white)
                    .font(.title2)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    HomeView()
        .environmentObject(SupplyViewModel())
} 