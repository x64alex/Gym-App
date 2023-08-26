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
        
        func deleteWorkout(index: Int){
            workouts = storage.deleteElementAtIndex(storageKey: "workouts", index: index)
        }
    }
}
