import Foundation

class RealWorkout: Codable {
    let id = UUID()
    let date: Date

    var exercises: [RealExercise] = []
    
    init(exercises: [RealExercise]) {
        self.exercises = exercises
        self.date = Date()
    }
    
}
