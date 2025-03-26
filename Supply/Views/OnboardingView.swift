import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var viewModel: SupplyViewModel
    @State private var currentStep = 0
    @State private var name = ""
    @State private var age = ""
    @State private var selectedGoals: Set<FitnessGoal> = []
    @State private var selectedPreferences: Set<DietaryPreference> = []
    
    var body: some View {
        ZStack {
            GradientBackground()
            
            VStack(spacing: 30) {
                // Progress bar
                ProgressView(value: Double(currentStep), total: 4)
                    .tint(.black)
                    .frame(height: 8)
                    .background(Color.black.opacity(0.2))
                    .cornerRadius(4)
                    .padding(.horizontal)
                
                // Content
                TabView(selection: $currentStep) {
                    welcomeView
                        .tag(0)
                    
                    nameAgeView
                        .tag(1)
                    
                    goalsView
                        .tag(2)
                    
                    preferencesView
                        .tag(3)
                    
                    finalView
                        .tag(4)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                // Navigation buttons
                HStack(spacing: 20) {
                    if currentStep > 0 {
                        Button(action: {
                            withAnimation {
                                currentStep -= 1
                            }
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                        }
                    }
                    
                    if currentStep < 4 {
                        Button(action: {
                            withAnimation {
                                currentStep += 1
                            }
                        }) {
                            Text(currentStep == 3 ? "Get Started" : "Next")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var welcomeView: some View {
        GlassCard {
            VStack(spacing: 20) {
                Image(systemName: "pills.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.black)
                
                Text("Welcome to Supply")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("Your personal supplement tracking companion")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black.opacity(0.7))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
    
    private var nameAgeView: some View {
        GlassCard {
            VStack(spacing: 20) {
                Text("Tell us about yourself")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Your name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.black)
                    
                    TextField("Your age", text: $age)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .foregroundColor(.black)
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
                    .foregroundColor(.black)
                
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
                                    .foregroundColor(selectedGoals.contains(goal) ? .white : .black)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedGoals.contains(goal) ? Color.black : Color.white.opacity(0.8))
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
                    .foregroundColor(.black)
                
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
                                    .foregroundColor(selectedPreferences.contains(preference) ? .white : .black)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedPreferences.contains(preference) ? Color.black : Color.white.opacity(0.8))
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
                    .foregroundColor(.black)
                
                Text("You're all set!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("Let's start tracking your supplements")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black.opacity(0.7))
                
                Button(action: {
                    viewModel.completeOnboarding(
                        name: name,
                        age: Int(age) ?? 0,
                        goals: Array(selectedGoals),
                        preferences: Array(selectedPreferences)
                    )
                }) {
                    Text("Get Started")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
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
