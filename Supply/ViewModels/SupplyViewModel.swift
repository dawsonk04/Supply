import Foundation
import SwiftUI

class SupplyViewModel: ObservableObject {
    @Published var currentUser: User
    @Published var errorMessage: String?
    @Published var isAuthenticated = false
    
    // User profile data
    @Published var userHeight: String = ""
    @Published var userWeight: String = ""
    @Published var userGender: Gender? = nil
    @Published var userGoals: Set<FitnessGoal> = []
    
    // Temporary storage for onboarding data before authentication
    private var pendingOnboardingData: OnboardingData?
    
    private let keychainManager = KeychainManager.shared
    private let userDataKey = "userData"
    
    init() {
        // Initialize with default user
        self.currentUser = User(
            name: "",
            age: 0,
            height: nil,
            weight: nil,
            gender: nil,
            fitnessGoals: [],
            dietaryPreferences: []           
        )
        loadUserData()
    }
    
    func completeOnboarding(name: String, age: Int, height: Double?, weight: Double?, gender: Gender?, goals: [FitnessGoal], preferences: [DietaryPreference]) {
        currentUser.name = name
        currentUser.age = age
        currentUser.height = height
        currentUser.weight = weight
        currentUser.gender = gender
        currentUser.fitnessGoals = goals
        currentUser.dietaryPreferences = preferences
        saveUserData()
    }
    
    private func saveUserData() {
        do {
            let encoder = JSONEncoder()
            let userData = try encoder.encode(currentUser)
            try keychainManager.saveSecureData(userData, forKey: userDataKey)
        } catch KeychainError.duplicateEntry {
            do {
                let encoder = JSONEncoder()
                let userData = try encoder.encode(currentUser)
                try keychainManager.updateSecureData(userData, forKey: userDataKey)
            } catch {
                errorMessage = "Failed to update user data: \(error.localizedDescription)"
            }
        } catch {
            errorMessage = "Failed to save user data: \(error.localizedDescription)"
        }
    }
    
    private func loadUserData() {
        do {
            let userData = try keychainManager.loadSecureData(forKey: userDataKey)
            let decoder = JSONDecoder()
            currentUser = try decoder.decode(User.self, from: userData)
        } catch KeychainError.unknown(errSecItemNotFound) {
            // No data saved yet, use default user
        } catch {
            errorMessage = "Failed to load user data: \(error.localizedDescription)"
        }
    }
    
    func saveOnboardingData(name: String, age: Int, height: Double?, weight: Double?, gender: Gender?, goals: [FitnessGoal], preferences: [DietaryPreference]) {
        pendingOnboardingData = OnboardingData(
            name: name,
            age: age,
            height: height,
            weight: weight,
            gender: gender,
            goals: goals,
            preferences: preferences
        )
    }
    
    func completeSignup(email: String, password: String) {
        // TODO: Implement actual signup logic with backend
        print("Completing signup for: \(email)")
        
        // For now, just mark as authenticated and apply onboarding data
        isAuthenticated = true
        
        if let onboardingData = pendingOnboardingData {
            completeOnboarding(
                name: onboardingData.name,
                age: onboardingData.age,
                height: onboardingData.height,
                weight: onboardingData.weight,
                gender: onboardingData.gender,
                goals: onboardingData.goals,
                preferences: onboardingData.preferences
            )
            pendingOnboardingData = nil
        }
    }
    
    func completeLogin(email: String, password: String) {
        // TODO: Implement actual login logic with backend
        print("Completing login for: \(email)")
        
        // For now, just mark as authenticated
        isAuthenticated = true
    }
}

struct OnboardingData {
    let name: String
    let age: Int
    let height: Double?
    let weight: Double?
    let gender: Gender?
    let goals: [FitnessGoal]
    let preferences: [DietaryPreference]
} 