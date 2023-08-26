import Foundation
import SharedFramework

extension WorkoutHome {
    class ViewModel: ObservableObject {
        private var storage: WorkoutStorage
        @Published var workouts: [Workout] = []
        
        init(storage: WorkoutStorage) {
            self.storage = storage
        }

        
        func loadWorkouts() {
            workouts = storage.getArray(storageKey: "workouts")
            
        }
        
        func deleteWorkout(workout: Workout){
            workouts = storage.deleteElement(storageKey: "workouts", element: workout)
        }
    }
}
