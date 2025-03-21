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
        self.currentUser = User()
        loadFromUserDefaults()
        loadRecommendedSupplements()
    }
    
    func updateUserProfile(supplements: String, height: String, weight: String, gender: String, goals: Set<FitnessGoal>) {
        userSupplements = supplements
        userHeight = height
        userWeight = weight
        userGender = gender
        userGoals = goals
        
        // Update current user
        if let weightDouble = Double(weight) {
            currentUser.weight = weightDouble
        }
        if let heightDouble = Double(height) {
            currentUser.height = heightDouble
        }
        
        currentUser.fitnessGoals = Array(goals)
        
        saveToUserDefaults()
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
        let userData: [String: Any] = [
            "supplements": userSupplements,
            "height": userHeight,
            "weight": userWeight,
            "gender": userGender,
            "goals": userGoals.map { $0.rawValue }
        ]
        UserDefaults.standard.set(userData, forKey: "userData")
    }
    
    private func loadFromUserDefaults() {
        guard let userData = UserDefaults.standard.dictionary(forKey: "userData") else { return }
        
        userSupplements = userData["supplements"] as? String ?? ""
        userHeight = userData["height"] as? String ?? ""
        userWeight = userData["weight"] as? String ?? ""
        userGender = userData["gender"] as? String ?? ""
        if let goalStrings = userData["goals"] as? [String] {
            userGoals = Set(goalStrings.compactMap { rawValue in
                FitnessGoal.allCases.first { $0.rawValue == rawValue }
            })
        }
    }
} 