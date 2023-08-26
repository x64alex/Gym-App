import Foundation
import SharedFramework

extension StartWorkoutView {
    class ViewModel: ObservableObject {
        @Published var workout: Workout
        @Published var exercise: Exercise
        private var exerciseIndex = 0
        @Published var setIndex = 1
        @Published var finished = false
        
        private var workoutNumber: Int
        private var storage: WorkoutStorage
        @Published var secondsRemaining: Int = 61
        private var notificationManager = NotificationManager()


        private var starTimerDate: Date = Date()
        
        private var timer: Timer?
        @Published var buttonText = "done"

        init(workout: Workout, index: Int, storage: WorkoutStorage) {
            self.workout = workout
            exercise = workout.exercises[exerciseIndex]
            
            self.workoutNumber = index
            self.storage = storage
            
            
            workout.startDate = Date()
            notificationManager.requestAuthorization()
        }
        
        func next() {
            workout.exercises[exerciseIndex] = exercise
            _ = storage.updateElementAtIndex(storageKey: "workouts", index: workoutNumber, newElement: workout)
            
            
            if(buttonText == "done"){
                notificationManager.scheduleNotification(notificationTitle: "Break over!", notificationBody: "Your break is over get back to work", timeInterval: 60)
                
                starTimerDate = Date()
                
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
                notificationManager.removeAllNotifications()
                secondsRemaining = 61
                buttonText = "done"
            }
        }
        
        func doneWorkout() {
            workout.duration = Int(Date() - (workout.startDate ?? Date()))
            _ = storage.addElementArray(storageKey: "doneworkouts", element: workout)
            notificationManager.removeAllNotifications()
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
        
        func updateTimer() {
            let timeInterval = Int(Date() - starTimerDate)
            secondsRemaining = 60 - timeInterval
            updateCountdown()
        }
    }
}
