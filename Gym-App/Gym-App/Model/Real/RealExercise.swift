import Foundation

class RealExercise: Codable, Identifiable {
    var id = UUID()
    var repetitions: [Repetition]
    var name: String
    
    init(repetitions: [Repetition], name: String) {
        self.repetitions = repetitions
        self.name = name
    }
}
