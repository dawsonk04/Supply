import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var viewModel: SupplyViewModel
    @State private var showingEditProfile = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Personal Information")) {
                    HStack {
                        Text("Age")
                        Spacer()
                        Text("\(viewModel.currentUser.age)")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Weight")
                        Spacer()
                        Text("\(String(format: "%.1f kg", viewModel.currentUser.weight))")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Height")
                        Spacer()
                        Text("\(String(format: "%.1f cm", viewModel.currentUser.height))")
                            .foregroundColor(.secondary)
                    }
                }
                
                Section(header: Text("Fitness Goals")) {
                    ForEach(viewModel.currentUser.fitnessGoals, id: \.self) { goal in
                        Text(goal.rawValue)
                    }
                }
                
                Section(header: Text("Dietary Preferences")) {
                    ForEach(viewModel.currentUser.dietaryPreferences, id: \.self) { preference in
                        Text(preference.rawValue)
                    }
                }
                
                Section {
                    Button(action: {
                        showingEditProfile = true
                    }) {
                        Text("Edit Profile")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $showingEditProfile) {
                EditProfileView()
            }
        }
    }
}

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: SupplyViewModel
    
    @State private var age: String = ""
    @State private var weight: String = ""
    @State private var height: String = ""
    @State private var selectedGoals: Set<FitnessGoal> = []
    @State private var selectedPreferences: Set<DietaryPreference> = []
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                    
                    TextField("Weight (kg)", text: $weight)
                        .keyboardType(.decimalPad)
                    
                    TextField("Height (cm)", text: $height)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Fitness Goals")) {
                    ForEach(FitnessGoal.allCases, id: \.self) { goal in
                        Toggle(goal.rawValue, isOn: Binding(
                            get: { selectedGoals.contains(goal) },
                            set: { isSelected in
                                if isSelected {
                                    selectedGoals.insert(goal)
                                } else {
                                    selectedGoals.remove(goal)
                                }
                            }
                        ))
                    }
                }
                
                Section(header: Text("Dietary Preferences")) {
                    ForEach(DietaryPreference.allCases, id: \.self) { preference in
                        Toggle(preference.rawValue, isOn: Binding(
                            get: { selectedPreferences.contains(preference) },
                            set: { isSelected in
                                if isSelected {
                                    selectedPreferences.insert(preference)
                                } else {
                                    selectedPreferences.remove(preference)
                                }
                            }
                        ))
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    saveProfile()
                }
            )
            .onAppear {
                loadCurrentProfile()
            }
        }
    }
    
    private func loadCurrentProfile() {
        age = String(viewModel.currentUser.age)
        weight = String(viewModel.currentUser.weight)
        height = String(viewModel.currentUser.height)
        selectedGoals = Set(viewModel.currentUser.fitnessGoals)
        selectedPreferences = Set(viewModel.currentUser.dietaryPreferences)
    }
    
    private func saveProfile() {
        if let ageInt = Int(age),
           let weightDouble = Double(weight),
           let heightDouble = Double(height) {
            viewModel.updateUserProfile(
                age: ageInt,
                weight: weightDouble,
                height: heightDouble,
                goals: Array(selectedGoals),
                preferences: Array(selectedPreferences)
            )
            dismiss()
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(SupplyViewModel())
} 