import SwiftUI

struct AddWorkoutView: View {
    @State private var exerciseName = ""
    @State private var workoutName = ""
    @State private var workoutExercises:[Exercise] = []
    @State private var allExercisesNames:[String] = []
    
    @State var setsNumber: Int = 0
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField("Enter workout name", text: $workoutName)
            ForEach(0..<workoutExercises.count, id: \.self) { workoutIndex in
                HStack(spacing: 0) {
                    Text(workoutExercises[workoutIndex].name)
                    Spacer()
                    Text(workoutExercises[workoutIndex].getSets())
                }.frame(height: 20)
            }.frame(height: CGFloat(workoutExercises.count)*20)
            
            VStack(spacing: 0) {

                
                Picker(selection: $exerciseName, label: Text("Favorite Food")) {
                    ForEach(allExercisesNames, id:\.self) { exercise in // <2>
                        Text(exercise)
                    }
                }
                
                Stepper("Sets: \(setsNumber)", value: $setsNumber)
                
                Button("Add Exercise") {
                    addExercise()
                }

            }
            
            Button("Add workout") {
                addWorkout()
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .onAppear {
            getAllExercise()
        }
        
        
    }
    
    func getAllExercise(){
        if let data = UserDefaults.standard.data(forKey: "exercises") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                var allExercises = try decoder.decode([Exercise].self, from: data)
                
                allExercisesNames = allExercises.map{ (exercise) -> String in
                    return exercise.name
                }

            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
    }
    
    func addExercise(){
        var newExercise = Exercise(sets: setsNumber, name: exerciseName)
        newExercise.sets = setsNumber
        workoutExercises.append(newExercise)
    }
    
    func addWorkout(){
        var workout = Workout(name: workoutName, exercises: workoutExercises)
        if let data = UserDefaults.standard.data(forKey: "workouts") {
            do {
                let decoder = JSONDecoder()
                let encoder = JSONEncoder()

                var workouts = try decoder.decode([Workout].self, from: data)
                
                workouts.append(workout)
                
                let data = try encoder.encode(workouts)
                
                UserDefaults.standard.set(data, forKey: "workouts")

            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }else{
            var workouts = [workout]
            
            do {
                let encoder = JSONEncoder()

                let data = try encoder.encode(workouts)
                
                UserDefaults.standard.set(data, forKey: "workouts")

            } catch {
                print("Unable to Encode Note (\(error))")
            }
        }
    }
    
    
}

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView()
    }
}
