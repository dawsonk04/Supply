import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var viewModel: SupplyViewModel
    @State private var currentStep = 0
    @State private var name = ""
    @State private var selectedAge = 25
    @State private var selectedHeightFeet = 5
    @State private var selectedHeightInches = 8
    @State private var selectedWeight = 150
    @State private var selectedGender: Gender? = nil
    @State private var selectedGoals: Set<FitnessGoal> = []
    @State private var selectedPreferences: Set<DietaryPreference> = []
    
    // Arrays for picker data
    private let ageRange = Array(13...75)
    private let feetRange = Array(3...7)
    private let inchesRange = Array(0...11)
    private let weightRange = Array(stride(from: 50, through: 500, by: 5))
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 30) {
                if currentStep > 0 {
                    // Progress bar - only show after first screen
                    ProgressView(value: Double(currentStep - 1), total: 4)
                        .tint(Color(hex: "4A90E2"))
                        .frame(height: 6)
                        .background(Color(hex: "DEE2E6"))
                        .cornerRadius(3)
                        .padding(.horizontal)
                }
                
                // Content
                TabView(selection: $currentStep) {
                    welcomeView
                        .tag(0)
                    
                    nameAgeView
                        .tag(1)
                    
                    heightWeightGenderView
                        .tag(2)
                    
                    goalsView
                        .tag(3)
                    
                    preferencesView
                        .tag(4)
                    
                    finalView
                        .tag(5)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                // Navigation buttons - only show after first screen
                if currentStep > 0 {
                    HStack(spacing: 20) {
                        if currentStep > 1 {
                            Button(action: {
                                withAnimation {
                                    currentStep -= 1
                                }
                            }) {
                                HStack {
                                    Image(systemName: "chevron.left")
                                    Text("Back")
                                }
                                .foregroundColor(Color(hex: "495057"))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(hex: "E9ECEF"))
                                .cornerRadius(10)
                            }
                        }
                        
                        Button(action: {
                            withAnimation {
                                currentStep += 1
                            }
                        }) {
                            Text(currentStep == 4 ? "Get Started" : "Next")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(hex: "4A90E2"))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var welcomeView: some View {
        VStack(spacing: 0) {
            // Logo in top-left corner
            HStack {
                Image("SupplyLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 60)
            
            // Main content
            VStack(spacing: 40) {
                VStack(spacing: 24) {
                    Image("SupplyLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                    
                    VStack(spacing: 8) {
                        Text("Welcome To")
                            .font(.system(size: 32, weight: .regular))
                        Text("Supply")
                            .font(.system(size: 32, weight: .regular))
                    }
                }
                .padding(.top, 40)
                
                VStack(spacing: 8) {
                    Text("Feel Better. Perform Better.")
                        .font(.system(size: 20))
                        .foregroundColor(Color(hex: "4A90E2"))
                    Text("Live Better")
                        .font(.system(size: 20))
                        .foregroundColor(Color(hex: "4A90E2"))
                }
                
                Spacer()
                
                VStack(spacing: 16) {
                    Text("Just Answer a Few Quick Questions to Get Started")
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black.opacity(0.8))
                    
                    Button(action: {
                        withAnimation {
                            currentStep += 1
                        }
                    }) {
                        Text("Get Started")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color(hex: "4A90E2"))
                            .cornerRadius(28)
                    }
                    .padding(.horizontal, 24)
                    
                    Text("On Average Takes Less Than 60 Seconds To Complete")
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.6))
                }
                .padding(.bottom, 40)
            }
        }
    }
    
    private var nameAgeView: some View {
        GlassCard {
            VStack(spacing: 20) {
                Text("Tell us about yourself")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "212529"))
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Your name")
                        .foregroundColor(Color(hex: "6C757D"))
                    
                    TextField("Enter your name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(Color(hex: "212529"))
                    
                    Text("Your age")
                        .foregroundColor(Color(hex: "6C757D"))
                    
                    Picker("Age", selection: $selectedAge) {
                        ForEach(ageRange, id: \.self) { age in
                            Text("\(age)")
                                .foregroundColor(Color(hex: "212529"))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 100)
                }
                .padding(.top)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
    
    private var heightWeightGenderView: some View {
        GlassCard {
            VStack(spacing: 20) {
                Text("Your Physical Information")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "212529"))
                
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Height")
                            .font(.headline)
                            .foregroundColor(Color(hex: "212529"))
                        
                        HStack {
                            VStack {
                                Text("Feet")
                                    .font(.subheadline)
                                    .foregroundColor(Color(hex: "6C757D"))
                                
                                Picker("Feet", selection: $selectedHeightFeet) {
                                    ForEach(feetRange, id: \.self) { feet in
                                        Text("\(feet) ft")
                                            .foregroundColor(Color(hex: "212529"))
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(height: 100)
                            }
                            
                            VStack {
                                Text("Inches")
                                    .font(.subheadline)
                                    .foregroundColor(Color(hex: "6C757D"))
                                
                                Picker("Inches", selection: $selectedHeightInches) {
                                    ForEach(inchesRange, id: \.self) { inches in
                                        Text("\(inches) in")
                                            .foregroundColor(Color(hex: "212529"))
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(height: 100)
                            }
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Weight (lbs)")
                            .font(.headline)
                            .foregroundColor(Color(hex: "212529"))
                        
                        Picker("Weight", selection: $selectedWeight) {
                            ForEach(weightRange, id: \.self) { weight in
                                Text("\(weight) lbs")
                                    .foregroundColor(Color(hex: "212529"))
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 100)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Gender")
                            .font(.headline)
                            .foregroundColor(Color(hex: "212529"))
                        
                        HStack(spacing: 15) {
                            ForEach(Gender.allCases, id: \.self) { gender in
                                Button(action: {
                                    selectedGender = gender
                                }) {
                                    Text(gender.rawValue)
                                        .foregroundColor(selectedGender == gender ? .white : Color(hex: "495057"))
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(selectedGender == gender ? Color(hex: "4A90E2") : Color(hex: "E9ECEF"))
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                }
                .padding(.top)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
    
    private var goalsView: some View {
        GlassCard {
            VStack(spacing: 20) {
                Text("What are your fitness goals?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "212529"))
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                        ForEach(FitnessGoal.allCases, id: \.self) { goal in
                            Button(action: {
                                if selectedGoals.contains(goal) {
                                    selectedGoals.remove(goal)
                                } else {
                                    selectedGoals.insert(goal)
                                }
                            }) {
                                Text(goal.rawValue)
                                    .foregroundColor(selectedGoals.contains(goal) ? .white : Color(hex: "495057"))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedGoals.contains(goal) ? Color(hex: "4A90E2") : Color(hex: "E9ECEF"))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
    
    private var preferencesView: some View {
        GlassCard {
            VStack(spacing: 20) {
                Text("Any dietary preferences?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "212529"))
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                        ForEach(DietaryPreference.allCases, id: \.self) { preference in
                            Button(action: {
                                if selectedPreferences.contains(preference) {
                                    selectedPreferences.remove(preference)
                                } else {
                                    selectedPreferences.insert(preference)
                                }
                            }) {
                                Text(preference.rawValue)
                                    .foregroundColor(selectedPreferences.contains(preference) ? .white : Color(hex: "495057"))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedPreferences.contains(preference) ? Color(hex: "4A90E2") : Color(hex: "E9ECEF"))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
    
    private var finalView: some View {
        GlassCard {
            VStack(spacing: 20) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(Color(hex: "4A90E2"))
                
                Text("You're all set!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "212529"))
                
                Text("Let's start tracking your supplements")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hex: "6C757D"))
                
                Button(action: {
                    viewModel.completeOnboarding(
                        name: name,
                        age: selectedAge,
                        height: Double(selectedHeightFeet) * 0.3048 + Double(selectedHeightInches) * 0.0254,
                        weight: Double(selectedWeight) * 0.453592, // Convert pounds to kg
                        gender: selectedGender,
                        goals: Array(selectedGoals),
                        preferences: Array(selectedPreferences)
                    )
                }) {
                    Text("Get Started")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "4A90E2"))
                        .cornerRadius(10)
                }
                .padding(.top)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(SupplyViewModel())
} 
