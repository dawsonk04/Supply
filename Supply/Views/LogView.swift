import SwiftUI

struct LogView: View {
    @EnvironmentObject var viewModel: SupplyViewModel
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            ZStack {
                GradientBackground()
                
                ScrollView {
                    VStack(spacing: 20) {
                        datePicker
                        supplementLog
                    }
                    .padding()
                }
            }
            .navigationTitle("Log")
            .navigationBarTitleDisplayMode(.large)
            .foregroundColor(.white)
        }
    }
    
    private var datePicker: some View {
        GlassCard {
            DatePicker(
                "Select Date",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .accentColor(.white)
        }
    }
    
    private var supplementLog: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 15) {
                Text("Supplements Taken")
                    .font(.title2)
                    .foregroundColor(.white)
                
                if viewModel.currentUser.supplements.isEmpty {
                    Text("No supplements logged for this date")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(viewModel.currentUser.supplements) { supplement in
                        if supplement.isTaken {
                            supplementLogRow(supplement)
                        }
                    }
                }
            }
        }
    }
    
    private func supplementLogRow(_ supplement: Supplement) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(supplement.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text("\(supplement.dosage) - \(supplement.frequency)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .font(.title2)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    LogView()
        .environmentObject(SupplyViewModel())
} 