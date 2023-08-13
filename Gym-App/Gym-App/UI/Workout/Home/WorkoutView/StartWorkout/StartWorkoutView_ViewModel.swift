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
        @Published var secondsRemaining: Int = 61

        
        
        private var timer: Timer?
        @Published var buttonText = "done"

        init(workout: Workout, index: Int, storage: Storage) {
            self.workout = workout
            exercise = workout.exercises[exerciseIndex]
            
            self.workoutNumber = index
            self.storage = storage
            
            
            workout.startDate = Date()
        }
        
        func next() {
            workout.exercises[exerciseIndex] = exercise
            _ = storage.updateElementAtIndex(storageKey: "workouts", index: workoutNumber, newElement: workout)
            
            
            if(buttonText == "done"){
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                    self?.updateCountdown()
                }
                timer?.fire()
                
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
            else{
                timer?.invalidate()
                secondsRemaining = 61
                buttonText = "done"
                
                
                
            }
        }
        
        func saveWorkout() {
            
        }
        
        private func updateCountdown() {
            if secondsRemaining > 1 {
                secondsRemaining -= 1
                buttonText = String(secondsRemaining)
            } else {
                timer?.invalidate()
                secondsRemaining = 61
                buttonText = "done"
            }
        }
    }
}
