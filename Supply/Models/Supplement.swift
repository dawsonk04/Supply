import Foundation

enum SupplementCategory: String, Codable, CaseIterable {
    case vitamins = "Vitamins"
    case minerals = "Minerals"
    case protein = "Protein"
    case preWorkout = "Pre-Workout"
    case postWorkout = "Post-Workout"
    case other = "Other"
}

struct Supplement: Identifiable, Codable {
    let id = UUID()
    var name: String
    var description: String
    var benefits: [String]
    var dosage: String
    var frequency: String
    var category: SupplementCategory
    var isTaken: Bool = false
} 