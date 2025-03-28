import Foundation

struct User: Codable, Identifiable {
    var id = UUID()
    var name: String
    var age: Int
    var height: Double?
    var weight: Double?
    var gender: Gender?
    var fitnessGoals: [FitnessGoal]
    var dietaryPreferences: [DietaryPreference]
    var supplements: [Supplement]
    
    // Helper computed properties
    var heightInFeet: Int? {
        guard let height = height else { return nil }
        // Convert meters to feet (1 meter = 3.28084 feet)
        return Int(height * 3.28084)
    }
    
    var heightInInches: Int? {
        guard let height = height else { return nil }
        // Convert meters to total inches, then get remainder after feet
        let totalInches = height * 39.3701
        return Int(totalInches) % 12
    }
    
    var weightInPounds: Int? {
        guard let weight = weight else { return nil }
        // Convert kg to pounds (1 kg = 2.20462 pounds)
        return Int(weight * 2.20462)
    }
}

enum FitnessGoal: String, Codable, CaseIterable {
    case buildMuscle = "Build Muscle"
    case loseWeight = "Lose Weight"
    case improveEnergy = "Improve Energy"
    case betterSleep = "Better Sleep"
    case enhanceFocus = "Enhance Focus"
    case reduceStress = "Reduce Stress"
    case improveImmunity = "Improve Immunity"
    case happierLifestyle = "Happier Lifestyle"
    case cognitiveClarity = "Cognitive Clarity"
}

enum DietaryPreference: String, Codable, CaseIterable {
    case vegan = "Vegan"
    case vegetarian = "Vegetarian"
    case paleo = "Paleo"
    case keto = "Keto"
    case glutenFree = "Gluten Free"
    case dairyFree = "Dairy Free"
    case none = "No Restrictions"
}

enum Gender: String, Codable, CaseIterable {
    case male = "Male"
    case female = "Female"
} 