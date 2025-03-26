import Foundation

struct User: Codable, Identifiable {
    var id = UUID()
    var name: String
    var age: Int
    var height: Double?
    var weight: Double?
    var fitnessGoals: [FitnessGoal]
    var dietaryPreferences: [DietaryPreference]
    var supplements: [Supplement]
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