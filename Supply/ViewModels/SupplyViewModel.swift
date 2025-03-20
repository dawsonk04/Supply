import Foundation
import SwiftUI

class SupplyViewModel: ObservableObject {
    @Published var currentUser: User
    @Published var recommendedSupplements: [Supplement] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init() {
        // Initialize with a default user
        self.currentUser = User()
        loadRecommendedSupplements()
    }
    
    func updateUserProfile(age: Int, weight: Double, height: Double, goals: [FitnessGoal], preferences: [DietaryPreference]) {
        currentUser.age = age
        currentUser.weight = weight
        currentUser.height = height
        currentUser.fitnessGoals = goals
        currentUser.dietaryPreferences = preferences
        loadRecommendedSupplements()
    }
    
    func toggleSupplementTaken(_ supplement: Supplement) {
        if let index = currentUser.supplements.firstIndex(where: { $0.id == supplement.id }) {
            currentUser.supplements[index].isTaken.toggle()
        }
    }
    
    func addSupplement(_ supplement: Supplement) {
        currentUser.supplements.append(supplement)
    }
    
    func loadRecommendedSupplements() {
        isLoading = true
        // TODO: Implement AI recommendation logic
        // For now, we'll use sample data
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
} 