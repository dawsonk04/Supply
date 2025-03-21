import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = SupplyViewModel()
    @ObservedObject var appStateManager: AppStateManager
    @State private var currentStep = 0
    @State private var currentSupplements = ""
    @State private var height = ""
    @State private var weight = ""
    @State private var gender = "Male"
    @State private var selectedGoals: Set<FitnessGoal> = []
    @State private var isAuthenticated = false
    
    var body: some View {
        if isAuthenticated {
            MainTabView()
                .environmentObject(viewModel)
                .onAppear {
                    // Save user data to ViewModel
                    viewModel.updateUserProfile(
                        supplements: currentSupplements,
                        height: height,
                        weight: weight,
                        gender: gender,
                        goals: selectedGoals
                    )
                    appStateManager.completeOnboarding()
                }
        } else {
            onboardingContent
        }
    }
    
    private var onboardingContent: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 30) {
                switch currentStep {
                case 0:
                    supplementsStep
                case 1:
                    heightWeightStep
                case 2:
                    goalsStep
                case 3:
                    authStep
                default:
                    EmptyView()
                }
            }
            .padding()
        }
    }
    
    private var supplementsStep: some View {
        VStack(spacing: 20) {
            Text("What supplements are you currently using?")
                .font(.title2)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            TextEditor(text: $currentSupplements)
                .frame(height: 100)
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
                .foregroundColor(.white)
            
            Button(action: { currentStep += 1 }) {
                Text("Next")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
    }
    
    private var heightWeightStep: some View {
        VStack(spacing: 20) {
            Text("Tell us about yourself")
                .font(.title2)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            TextField("Height", text: $height)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(.black)
            
            TextField("Weight", text: $weight)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(.black)
            
            Picker("Gender", selection: $gender) {
                Text("Male").tag("Male")
                Text("Female").tag("Female")
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Button(action: { currentStep += 1 }) {
                Text("Next")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
    }
    
    private var goalsStep: some View {
        VStack(spacing: 20) {
            Text("What are your goals?")
                .font(.title2)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(FitnessGoal.allCases, id: \.self) { goal in
                        Button(action: {
                            if selectedGoals.contains(goal) {
                                selectedGoals.remove(goal)
                            } else {
                                selectedGoals.insert(goal)
                            }
                        }) {
                            HStack {
                                Image(systemName: selectedGoals.contains(goal) ? "checkmark.square.fill" : "square")
                                Text(goal.rawValue)
                                Spacer()
                            }
                            .foregroundColor(.white)
                        }
                    }
                }
            }
            
            Button(action: { currentStep += 1 }) {
                Text("Next")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
            .disabled(selectedGoals.isEmpty)
        }
    }
    
    private var authStep: some View {
        VStack(spacing: 20) {
            Text("Create an account to save your preferences")
                .font(.title2)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Button(action: {
                // Handle Google Sign In
                simulateAuthentication()
            }) {
                HStack {
                    Image(systemName: "g.circle.fill")
                    Text("Continue with Google")
                }
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            }
            
            Button(action: {
                // Handle Email Sign In
                simulateAuthentication()
            }) {
                Text("Sign in with Email")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                // Handle Create Account
                simulateAuthentication()
            }) {
                Text("Create Account")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
    }
    
    private func simulateAuthentication() {
        isAuthenticated = true
    }
}

#Preview {
    OnboardingView(appStateManager: AppStateManager())
} 