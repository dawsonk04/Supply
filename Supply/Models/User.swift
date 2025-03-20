import Foundation

struct User: Codable, Identifiable {
    let id: String
    var age: Int
    var weight: Double
    var height: Double
    var fitnessGoals: [FitnessGoal]
    var dietaryPreferences: [DietaryPreference]
    var supplements: [Supplement]
    
    init(id: String = UUID().uuidString,
         age: Int = 0,
         weight: Double = 0.0,
         height: Double = 0.0,
         fitnessGoals: [FitnessGoal] = [],
         dietaryPreferences: [DietaryPreference] = [],
         supplements: [Supplement] = []) {
        self.id = id
        self.age = age
        self.weight = weight
        self.height = height
        self.fitnessGoals = fitnessGoals
        self.dietaryPreferences = dietaryPreferences
        self.supplements = supplements
    }
}

enum FitnessGoal: String, Codable, CaseIterable {
    case muscleGain = "Muscle Gain"
    case weightLoss = "Weight Loss"
    case energyBoost = "Energy Boost"
    case recovery = "Recovery"
    case generalHealth = "General Health"
}

enum DietaryPreference: String, Codable, CaseIterable {
    case vegetarian = "Vegetarian"
    case vegan = "Vegan"
    case glutenFree = "Gluten Free"
    case dairyFree = "Dairy Free"
    case none = "No Restrictions"
} 