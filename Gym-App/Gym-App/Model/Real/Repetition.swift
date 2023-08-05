import Foundation

class Repetition: Codable, Identifiable {
    var id = UUID()
    var reps: Int
    var weight: Int //in kg
    //TODO: set lb and kg in setings
    
    init(reps: Int, weight: Int) {
        self.reps = reps
        self.weight = weight
    }

}
