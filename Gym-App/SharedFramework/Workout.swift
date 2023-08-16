import Foundation

public class Workout: Codable, CustomStringConvertible, Identifiable {
    public var description: String{
        let value =  exercises.reduce("Name: \(self.name) \nWorkout: \n\n") { partialResult, ex in
            let sets = ex.repetitions.reduce("") { partialResult, rep in
                partialResult + " Repetitions: \(rep.reps) Weight: \(rep.weight)\n"
            }
            return partialResult + ex.name + " " + String(ex.getSets())+" sets \n"+sets+"\n\n"
        }
        guard let date = self.startDate else{ return value}
        
        let dtFormatter = DateFormatter()
        dtFormatter.dateStyle = .medium
        dtFormatter.timeStyle = .short

        let formattedDateTime = dtFormatter.string(from: date)
        return "Date: \(formattedDateTime)\n" + "Duration: \(duration) seconds\n\n" + value
    }
    
    public let id = UUID()
    public var startDate: Date? = nil
    public var duration: Int = 0
    
    public var exercises: [Exercise] = []
    public var name: String
    
    public init(name: String, exercises: [Exercise]) {
        self.name = name
        self.exercises = exercises
    }
    
    public func getSets() -> Int {
        return exercises.reduce(0) { partialResult, ex in
            partialResult+ex.getSets()
        }
    }
    
    
}

