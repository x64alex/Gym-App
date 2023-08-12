import Foundation

class Exercise: Codable, Identifiable, Hashable {
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    private var sets: Int
    var name: String
    var type: String
    var mainMuscleGroup: String
    var repetitions: [Repetition]

    
    init(sets: Int = 0, type: String, name: String, mainMuscleGroup: String) {
        self.sets = sets
        self.type = type
        self.name = name
        self.mainMuscleGroup = mainMuscleGroup
        self.repetitions = Array(repeating: Repetition(reps: 0, weight: 0), count: sets)
    }
    
    func getSets() -> Int {
        return self.sets
    }
    func setSets(numberOfSets: Int) {
        self.sets = numberOfSets
        self.repetitions = Array(repeating: Repetition(reps: 0, weight: 0), count: numberOfSets)
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
