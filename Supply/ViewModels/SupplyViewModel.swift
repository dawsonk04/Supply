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
    @Published var userGender: String = ""
    @Published var userGoals: Set<FitnessGoal> = []
    
    init() {
        // Initialize with default user
        self.currentUser = User(
            name: "",
            age: 0,
            height: nil,
            weight: nil,
            fitnessGoals: [],
            dietaryPreferences: [],
            supplements: []
        )
        loadFromUserDefaults()
        loadRecommendedSupplements()
    }
    
    func completeOnboarding(name: String, age: Int, goals: [FitnessGoal], preferences: [DietaryPreference]) {
        currentUser.name = name
        currentUser.age = age
        currentUser.fitnessGoals = goals
        currentUser.dietaryPreferences = preferences
        saveToUserDefaults()
    }
    
    func updateUserProfile(name: String, age: Int, goals: [FitnessGoal], preferences: [DietaryPreference]) {
        currentUser.name = name
        currentUser.age = age
        currentUser.fitnessGoals = goals
        currentUser.dietaryPreferences = preferences
        saveToUserDefaults()
    }
    
    func toggleSupplementTaken(_ supplement: Supplement) {
        if let index = currentUser.supplements.firstIndex(where: { $0.id == supplement.id }) {
            currentUser.supplements[index].isTaken.toggle()
            saveToUserDefaults()
        }
    }
    
    func addSupplement(_ supplement: Supplement) {
        currentUser.supplements.append(supplement)
        saveToUserDefaults()
    }
    
    func removeSupplement(_ supplement: Supplement) {
        currentUser.supplements.removeAll { $0.id == supplement.id }
        saveToUserDefaults()
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
    
    private func saveToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(currentUser) {
            UserDefaults.standard.set(encoded, forKey: "userData")
        }
    }
    
    private func loadFromUserDefaults() {
        if let userData = UserDefaults.standard.data(forKey: "userData"),
           let decodedUser = try? JSONDecoder().decode(User.self, from: userData) {
            self.currentUser = decodedUser
        }
    }
} 