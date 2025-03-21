import SwiftUI

struct LogView: View {
    @EnvironmentObject var viewModel: SupplyViewModel
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
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
        DatePicker(
            "Select Date",
            selection: $selectedDate,
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
    }
    
    private var supplementLog: some View {
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
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
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