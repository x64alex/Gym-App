import Foundation

class Workout: Codable, CustomStringConvertible, Identifiable {
    var description: String{
        let value =  exercises.reduce("Name: \(self.name) \nWorkout: \n\n") { partialResult, ex in
            var sets = ex.repetitions.reduce("") { partialResult, rep in
                partialResult + " Repetitions: \(rep.reps) Weight: \(rep.weight)\n"
            }
            return partialResult + ex.name + " " + String(ex.getSets())+" sets \n"+sets+"\n\n"
        }
        guard let date = self.startDate else{ return value}
        
        let dtFormatter = DateFormatter()
        dtFormatter.dateStyle = .medium
        dtFormatter.timeStyle = .short

        let formattedDateTime = dtFormatter.string(from: date)
        return "Date: \(formattedDateTime)\n\n" + value
    }
    
    let id = UUID()
    var startDate: Date? = nil
    var duration: Date? = nil
    
    var exercises: [Exercise] = []
    var name: String
    
    init(name: String, exercises: [Exercise]) {
        self.name = name
        self.exercises = exercises
    }
    
    func getSets() -> Int {
        return exercises.reduce(0) { partialResult, ex in
            partialResult+ex.getSets()
        }
    }
    
    func getRealWorkout() -> RealWorkout{
        var realExercises:[RealExercise] = []
        
        for exercise in exercises{
            
            realExercises.append(exercise.getRealExercise())
        }
        
        return RealWorkout(exercises: realExercises)
    }
    
    
}
