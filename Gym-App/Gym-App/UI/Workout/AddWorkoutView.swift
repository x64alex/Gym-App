import SwiftUI

struct AddWorkoutView: View {
    @EnvironmentObject private var storage: Storage

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
        let exercises: [Exercise] = storage.getArray(storageKey: "exercises")
        allExercisesNames = exercises.map{ (exercise) -> String in
            return exercise.name
        }
    }
    
    func addExercise(){
        let newExercise = Exercise(sets: setsNumber, name: exerciseName)
        newExercise.sets = setsNumber
        workoutExercises.append(newExercise)
    }
    
    func addWorkout(){
        let workout = Workout(name: workoutName, exercises: workoutExercises)
        _ = storage.addElementArray(storageKey: "workouts", element: workout)
    }
    
    
}

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView()
    }
}
