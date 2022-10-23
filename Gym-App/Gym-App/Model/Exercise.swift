import Foundation

class Exercise: Identifiable {
    var id: ObjectIdentifier
    var sets: Int
    var name: String
    
    init(sets: Int, name: String) {
        self.id = ObjectIdentifier(Exercise.self)
        self.sets = sets
        self.name = name
    }
    
    func getSets() -> String {
        return String(self.sets)
    }
}
