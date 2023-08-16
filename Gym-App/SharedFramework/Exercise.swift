import Foundation

public class Exercise: Codable, Identifiable, Hashable {
    public static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id
    }
    
    public var id = UUID()
    private var sets: Int
    public var name: String
    public var type: String
    public var mainMuscleGroup: String
    public var repetitions: [Repetition]

    
    public init(sets: Int = 0, type: String, name: String, mainMuscleGroup: String) {
        self.sets = sets
        self.type = type
        self.name = name
        self.mainMuscleGroup = mainMuscleGroup
        self.repetitions = Array(repeating: Repetition(reps: 0, weight: 0), count: sets)
    }
    
    public func getSets() -> Int {
        return self.sets
    }
    public func setSets(numberOfSets: Int) {
        self.sets = numberOfSets
        self.repetitions = Array(repeating: Repetition(reps: 0, weight: 0), count: numberOfSets)
    }
    
    // Implement the hash(into:) method
    public func hash(into hasher: inout Hasher) {
        // Combine the hash values of the properties you want to use for comparison.
        hasher.combine(id)
        hasher.combine(sets)
        hasher.combine(name)
    }

}
