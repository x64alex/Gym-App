import Foundation

extension StartWorkoutView {
    class ViewModel: ObservableObject {
        @Published var workout: Workout
        @Published var exercise: Exercise
        private var exerciseIndex = 0
        @Published var setIndex = 1
        @Published var finished = false
        
        private var workoutNumber: Int
        private var storage: Storage
        
        
        @Published var buttonText = "done"

        init(workout: Workout, index: Int, storage: Storage) {
            self.workout = workout
            exercise = workout.exercises[exerciseIndex]
            
            self.workoutNumber = index
            self.storage = storage
        }
        
        func next() {
            workout.exercises[exerciseIndex] = exercise
            storage.updateElementAtIndex(storageKey: "workouts", index: workoutNumber, newElement: workout)
            
            if(setIndex < exercise.getSets()){
                setIndex += 1
            }
            else {
                if(exerciseIndex < workout.exercises.count - 1){
                    setIndex = 1
                    exerciseIndex += 1
                    exercise = workout.exercises[exerciseIndex]
                }
                else{
                    finished = true
                    print("Workout finished")
                }
            }
        }
        
        func saveWorkout() {
            
        }
    }
}
