import Foundation

class Exercise: Codable, Identifiable {
    var id = UUID()
    var sets: Int
    var name: String
    var repetitions: [Repetition]

    
    init(sets: Int, name: String) {
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
}
