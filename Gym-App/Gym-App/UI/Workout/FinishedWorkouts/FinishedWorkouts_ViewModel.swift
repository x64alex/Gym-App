import Foundation
extension FinishedWorkouts {
    
    class ViewModel: ObservableObject {
        private var storage: Storage
        @Published var workouts: [Workout] = []
        @Published var selectedDate: Date = Date() {
            didSet {
                loadWorkouts()
            }
        }
        
        init(storage: Storage) {
            self.storage = storage
        }

        
        func loadWorkouts() {
            var allworkouts: [Workout] = storage.getArray(storageKey: "doneworkouts")
            workouts = []
            
            // Select only from the date
            allworkouts.forEach { workout in
                guard let workoutDate = workout.startDate else{ return}
                
                if(workoutDate.isSameDay(as: selectedDate)){
                    workouts.append(workout)
                }
            }
        }
        
        func deleteWorkout(index: Int){
            workouts = storage.deleteElementAtIndex(storageKey: "doneworkouts", index: index)
        }
    }
}
