import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: SupplyViewModel
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        profileHeader
                        statsSection
                        goalsSection
                        supplementsSection
                    }
                    .padding()
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
            .foregroundColor(.white)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditing ? "Done" : "Edit") {
                        isEditing.toggle()
                    }
                }
            }
        }
    }
    
    private var profileHeader: some View {
        VStack(spacing: 15) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
            
            Text(viewModel.userGender)
                .font(.title2)
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
    }
    
    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Stats")
                .font(.title2)
                .foregroundColor(.white)
            
            HStack(spacing: 20) {
                statCard(title: "Height", value: viewModel.userHeight)
                statCard(title: "Weight", value: viewModel.userWeight)
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
    }
    
    private func statCard(title: String, value: String) -> some View {
        VStack(spacing: 5) {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
            
            if isEditing {
                TextField(value, text: Binding(
                    get: { value },
                    set: { newValue in
                        if title == "Height" {
                            viewModel.userHeight = newValue
                        } else {
                            viewModel.userWeight = newValue
                        }
                    }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text(value)
                    .font(.title3)
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var goalsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Goals")
                .font(.title2)
                .foregroundColor(.white)
            
            ForEach(Array(viewModel.userGoals), id: \.self) { goal in
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text(goal.rawValue)
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
    }
    
    private var supplementsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Current Supplements")
                .font(.title2)
                .foregroundColor(.white)
            
            if viewModel.currentUser.supplements.isEmpty {
                Text("No supplements added")
                    .foregroundColor(.gray)
            } else {
                ForEach(viewModel.currentUser.supplements) { supplement in
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
                    }
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    ProfileView()
        .environmentObject(SupplyViewModel())
} 