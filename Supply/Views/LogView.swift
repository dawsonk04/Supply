import SwiftUI

struct LogView: View {
    @EnvironmentObject private var viewModel: SupplyViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Today's Log")) {
                    if viewModel.currentUser.supplements.isEmpty {
                        Text("No supplements logged today")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(viewModel.currentUser.supplements) { supplement in
                            LogRow(supplement: supplement)
                        }
                    }
                }
                
                Section(header: Text("Statistics")) {
                    HStack {
                        Text("Total Supplements")
                        Spacer()
                        Text("\(viewModel.currentUser.supplements.count)")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Taken Today")
                        Spacer()
                        Text("\(viewModel.currentUser.supplements.filter { $0.isTaken }.count)")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Supplement Log")
        }
    }
}

struct LogRow: View {
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
            
            if supplement.isTaken {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    LogView()
        .environmentObject(SupplyViewModel())
} 