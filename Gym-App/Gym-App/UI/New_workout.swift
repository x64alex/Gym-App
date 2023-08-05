import SwiftUI

struct New_workout: View {
    var body: some View {
        Button("Add trainings") {
            var exercisesBack = [
                Exercise(sets: 3, name: "Assisted pull up"),
                Exercise(sets: 4, name: "Lat pull down"),
                Exercise(sets: 4, name: "Low row"),
                Exercise(sets: 3, name: "Triangle pull"),
                Exercise(sets: 4, name: "Biceps")
            ]
            
            var exercisesArms = [
                Exercise(sets: 3, name: "Triceps ex1"),
                Exercise(sets: 3, name: "Biceps ex1"),
                Exercise(sets: 4, name: "Triceps ex2"),
                Exercise(sets: 4, name: "Biceps ex3"),
                Exercise(sets: 3, name: "Triceps ex3"),
                Exercise(sets: 3, name: "Biceps ex3")
            ]

            var workouts = [
                Workout(name: "Back training", exercises: exercisesBack),
                Workout(name: "Arm training", exercises: exercisesArms)
            ]
            
            do {
                // Create JSON Encoder
                let encoder = JSONEncoder()

                // Encode Note
                let data = try encoder.encode(workouts)
                
                UserDefaults.standard.set(data, forKey: "workouts")

            } catch {
                print("Unable to Encode Note (\(error))")
            }
        }
    }
}

struct New_workout_Previews: PreviewProvider {
    static var previews: some View {
        New_workout()
    }
}
