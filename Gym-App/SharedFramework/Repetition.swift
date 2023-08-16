import Foundation

public class Repetition: Codable, Identifiable {
    public var id = UUID()
    public var reps: Int
    public var weight: Int //in kg
    //TODO: set lb and kg in setings
    
    public init(reps: Int, weight: Int) {
        self.reps = reps
        self.weight = weight
    }

}
