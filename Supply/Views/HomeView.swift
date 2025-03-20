import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: SupplyViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Today's Supplements")) {
                    if viewModel.currentUser.supplements.isEmpty {
                        Text("No supplements added yet")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(viewModel.currentUser.supplements) { supplement in
                            SupplementRow(supplement: supplement)
                        }
                    }
                }
                
                Section(header: Text("Quick Actions")) {
                    Button(action: {
                        // TODO: Implement add supplement action
                    }) {
                        Label("Add Supplement", systemImage: "plus.circle.fill")
                    }
                }
            }
            .navigationTitle("Supply")
        }
    }
}

struct SupplementRow: View {
    @EnvironmentObject private var viewModel: SupplyViewModel
    let supplement: Supplement
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(supplement.name)
                    .font(.headline)
                Text(supplement.dosage)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                viewModel.toggleSupplementTaken(supplement)
            }) {
                Image(systemName: supplement.isTaken ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(supplement.isTaken ? .green : .gray)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    HomeView()
        .environmentObject(SupplyViewModel())
} 