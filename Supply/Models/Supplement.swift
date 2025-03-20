import Foundation

struct Supplement: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let benefits: [String]
    let dosage: String
    let frequency: String
    var isTaken: Bool
    let category: SupplementCategory
    
    init(id: String = UUID().uuidString,
         name: String,
         description: String,
         benefits: [String],
         dosage: String,
         frequency: String,
         isTaken: Bool = false,
         category: SupplementCategory) {
        self.id = id
        self.name = name
        self.description = description
        self.benefits = benefits
        self.dosage = dosage
        self.frequency = frequency
        self.isTaken = isTaken
        self.category = category
    }
}

enum SupplementCategory: String, Codable, CaseIterable {
    case vitamins = "Vitamins"
    case minerals = "Minerals"
    case protein = "Protein"
    case preWorkout = "Pre-Workout"
    case postWorkout = "Post-Workout"
    case other = "Other"
} 