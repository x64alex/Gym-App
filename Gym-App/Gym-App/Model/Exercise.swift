import Foundation

class Exercise: Codable, Identifiable, Hashable {
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    var sets: Int
    var name: String
    var repetitions: [Repetition]

    
    init(sets: Int = 0, name: String) {
        self.sets = sets
        self.name = name
        self.repetitions = Array(repeating: Repetition(reps: 0, weight: 0), count: sets)
    }
    
    func getSets() -> String {
        return String(self.sets)
    }
    
    func getRealExercise() -> RealExercise {
        return RealExercise(repetitions: Array(repeating: Repetition(reps: 0, weight: 0), count: sets), name: name)
    }
    
    // Implement the hash(into:) method
    func hash(into hasher: inout Hasher) {
        // Combine the hash values of the properties you want to use for comparison.
        hasher.combine(id)
        hasher.combine(sets)
        hasher.combine(name)
    }

}
