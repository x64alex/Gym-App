import Foundation
import SharedFramework

extension FinishedWorkouts {
    
    class ViewModel: ObservableObject {
        private var storage: WorkoutStorage
        @Published var workouts: [Workout] = []
        @Published var selectedDate: Date = Date() {
            didSet {
                loadWorkouts()
            }
        }
        
        init(storage: WorkoutStorage) {
            self.storage = storage
        }

        
        func loadWorkouts() {
            let allworkouts: [Workout] = storage.getArray(storageKey: "doneworkouts")
            workouts = []
            allworkouts.forEach { workout in
                guard let workoutDate = workout.startDate else{ return}
                
                if(workoutDate.isSameDay(as: selectedDate)){
                    workouts.append(workout)
                }
            }
        }
        
        func deleteWorkout(workout: Workout){
            _ = storage.deleteElement(storageKey: "doneworkouts", element: workout)
            loadWorkouts()
        }
    }
}
