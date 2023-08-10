import SwiftUI

extension Workout_screen {
    class ViewModel: ObservableObject {
        @Published var workout: Workout = Workout(name: "", exercises: [])
        var workoutNumber = 0;
        
        init(workoutNumber: Int) {
            self.workoutNumber = workoutNumber
        }
                
        
        
        func loadWorkout() {
            if let data = UserDefaults.standard.data(forKey: "workouts") {
                do {
                    let decoder = JSONDecoder()

                    let workouts = try decoder.decode([Workout].self, from: data)                    
                    workout = workouts[workoutNumber]

                } catch {
                    print("Unable to Decode Note (\(error))")
                }
            }
        }
    }
}
