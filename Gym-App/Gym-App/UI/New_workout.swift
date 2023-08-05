import SwiftUI

struct New_workout: View {
    var body: some View {
        Button("Add back training") {
            var exercises = [
                Exercise(sets: 3, name: "Assisted pull up"),
                Exercise(sets: 4, name: "Lat pull down"),
                Exercise(sets: 4, name: "Low row"),
                Exercise(sets: 3, name: "Triangle pull"),
                Exercise(sets: 4, name: "Biceps")
            ]

            var workouts = [Workout(name: "Back training", exercises: exercises)]
            
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
