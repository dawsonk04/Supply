import Foundation
import SwiftUI

class SupplyViewModel: ObservableObject {
    @Published var currentUser: User
    @Published var recommendedSupplements: [Supplement] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // User profile data
    @Published var userSupplements: String = ""
    @Published var userHeight: String = ""
    @Published var userWeight: String = ""
    @Published var userGender: Gender? = nil
    @Published var userGoals: Set<FitnessGoal> = []
    
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
            dietaryPreferences: [],
            supplements: []
        )
        loadUserData()
        loadRecommendedSupplements()
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
    
    func updateUserProfile(name: String, age: Int, height: Double?, weight: Double?, gender: Gender?, goals: [FitnessGoal], preferences: [DietaryPreference]) {
        currentUser.name = name
        currentUser.age = age
        currentUser.height = height
        currentUser.weight = weight
        currentUser.gender = gender
        currentUser.fitnessGoals = goals
        currentUser.dietaryPreferences = preferences
        saveUserData()
    }
    
    func toggleSupplementTaken(_ supplement: Supplement) {
        if let index = currentUser.supplements.firstIndex(where: { $0.id == supplement.id }) {
            currentUser.supplements[index].isTaken.toggle()
            saveUserData()
        }
    }
    
    func addSupplement(_ supplement: Supplement) {
        currentUser.supplements.append(supplement)
        saveUserData()
    }
    
    func removeSupplement(_ supplement: Supplement) {
        currentUser.supplements.removeAll { $0.id == supplement.id }
        saveUserData()
    }
    
    private func loadRecommendedSupplements() {
        isLoading = true
        // Simulate API call with sample data
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.recommendedSupplements = [
                Supplement(
                    name: "Vitamin D3",
                    description: "Essential vitamin for bone health and immune function",
                    benefits: ["Stronger bones", "Improved immune system", "Better mood"],
                    dosage: "1000 IU",
                    frequency: "Once daily",
                    category: .vitamins
                ),
                Supplement(
                    name: "Whey Protein",
                    description: "High-quality protein for muscle recovery and growth",
                    benefits: ["Muscle growth", "Recovery", "Satiety"],
                    dosage: "30g",
                    frequency: "Post-workout",
                    category: .protein
                )
            ]
            self.isLoading = false
        }
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
} 