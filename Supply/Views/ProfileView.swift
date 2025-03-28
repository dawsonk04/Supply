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
                        if isEditing {
                            // Save changes
                            saveProfileChanges()
                        }
                        isEditing.toggle()
                    }
                }
            }
        }
    }
    
    private func saveProfileChanges() {
        // Convert weight from pounds to kg if present
        var weightInKg: Double? = nil
        if let weight = Double(viewModel.userWeight) {
            // Convert pounds to kg (1 pound = 0.453592 kg)
            weightInKg = weight * 0.453592
        }
        
        viewModel.updateUserProfile(
            name: viewModel.currentUser.name,
            age: viewModel.currentUser.age,
            height: viewModel.currentUser.height, // Keep existing height
            weight: weightInKg,
            gender: viewModel.userGender,
            goals: viewModel.currentUser.fitnessGoals,
            preferences: viewModel.currentUser.dietaryPreferences
        )
    }
    
    private var profileHeader: some View {
        VStack(spacing: 15) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
            
            Text(viewModel.currentUser.name)
                .font(.title)
                .foregroundColor(.white)
            
            Text("Age: \(viewModel.currentUser.age)")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))
            
            if let gender = viewModel.userGender {
                Text(gender.rawValue)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
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
                statCard(
                    title: "Height", 
                    value: (viewModel.currentUser.heightInFeet != nil && viewModel.currentUser.heightInInches != nil) ? 
                        "\(viewModel.currentUser.heightInFeet!)'\(viewModel.currentUser.heightInInches!)\""  : 
                        "Not set"
                )
                
                statCard(
                    title: "Weight", 
                    value: viewModel.currentUser.weightInPounds != nil ? 
                        "\(viewModel.currentUser.weightInPounds!) lbs" : 
                        "Not set"
                )
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
                if title == "Height" {
                    Text("Edit in settings")
                        .font(.caption)
                        .foregroundColor(.gray)
                } else if title == "Weight" {
                    TextField("Weight (lbs)", text: Binding(
                        get: { viewModel.userWeight },
                        set: { viewModel.userWeight = $0 }
                    ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                }
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