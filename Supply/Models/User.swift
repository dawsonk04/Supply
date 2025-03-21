import Foundation

enum FitnessGoal: String, Codable, CaseIterable {
    case buildMuscle = "Build Muscle"
    case happierLifestyle = "Happier Lifestyle"
    case cognitiveClarity = "Cognitive Clarity"
    case performance = "Performance"
    case betterSleep = "Better Sleep"
    case moreFocus = "More Focus"
}

enum DietaryPreference: String, Codable, CaseIterable {
    case vegan = "Vegan"
    case vegetarian = "Vegetarian"
    case paleo = "Paleo"
    case keto = "Keto"
    case none = "None"
}

struct User: Identifiable, Codable {
    var id = UUID()
    var age: Int = 0
    var weight: Double = 0
    var height: Double = 0
    var supplements: [Supplement] = []
    var fitnessGoals: [FitnessGoal] = []
    var dietaryPreferences: [DietaryPreference] = []
} 