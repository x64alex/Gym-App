import SwiftUI
import SharedFramework

extension Workout_screen {
    class ViewModel: ObservableObject {

        @Published var workout: Workout = Workout(name: "", exercises: [])
        var storage: WorkoutStorage
        var workoutNumber = 0;
        
        init(workoutNumber: Int, storage: WorkoutStorage) {
            self.workoutNumber = workoutNumber
            self.storage = storage
        }
        
        func loadWorkout() {
            workout = storage.getArray(storageKey: "workouts")[workoutNumber]
        }
    }
}
