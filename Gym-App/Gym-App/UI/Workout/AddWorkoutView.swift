import SwiftUI

struct AddWorkoutView: View {
    @EnvironmentObject private var storage: Storage

    @State private var exercise = Exercise(type: "", name: "", mainMuscleGroup: "")
    @State private var workoutName = ""
    @State private var workoutExercises: [Exercise] = []
    @State private var allExercises: [Exercise] = []
    
    @State var setsNumber: Int = 0
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField("Enter workout name", text: $workoutName)
            ForEach(0..<workoutExercises.count, id: \.self) { workoutIndex in
                HStack(spacing: 0) {
                    Text(workoutExercises[workoutIndex].name)
                    Spacer()
                    Text(String(workoutExercises[workoutIndex].getSets()))
                }.frame(height: 20)
            }.frame(height: CGFloat(workoutExercises.count)*20)
            
            VStack(spacing: 0) {
                Picker(selection: $exercise, label: Text("Favorite Food")) {
                    ForEach(allExercises, id:\.self) { exercise in // <2>
                        Text(exercise.name)
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
        allExercises = storage.getArray(storageKey: "exercises")
//        allExercisesNames = exercises.map{ (exercise) -> String in
//            return exercise.name
//        }
    }
    
    func addExercise(){
        exercise.setSets(numberOfSets: setsNumber)
        workoutExercises.append(exercise)
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
