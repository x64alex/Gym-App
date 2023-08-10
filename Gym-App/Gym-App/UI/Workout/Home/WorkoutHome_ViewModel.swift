import Foundation

extension WorkoutHome {
    class ViewModel: ObservableObject {
        private var storage: Storage
        @Published var workouts: [Workout] = []
        
        init(storage: Storage) {
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
