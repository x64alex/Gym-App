import SwiftUI

extension Workout_screen {
    class ViewModel: ObservableObject {
        @Published var workout: Workout = Workout(name: "", exercises: [])
        
                
        func loadWorkout() {
            if let data = UserDefaults.standard.data(forKey: "workouts") {
                do {
                    // Create JSON Decoder
                    let decoder = JSONDecoder()

                    // Decode Note
                    let workouts = try decoder.decode([Workout].self, from: data)
                    
                    workout = workouts[0]

                } catch {
                    print("Unable to Decode Note (\(error))")
                }
            }
        }
    }
}
