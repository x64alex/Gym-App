import SwiftUI

struct AddExercise: View {
    @State var name: String = ""
    @State var exerciseType: String = ""
    @State var mainMuscleGroup: String = ""

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @EnvironmentObject private var storage: Storage

    
    var body: some View {
        VStack {
            Text("Name").font(.headline)
            TextField("Enter exercise name", text: $name)
            Picker(selection: $exerciseType, label: Text("")) {
                ForEach(AppConstants.exerciseTypes, id:\.self) { exerciseType in
                    Text(exerciseType)
                }
            }
            Picker(selection: $exerciseType, label: Text("")) {
                ForEach(AppConstants.muscleGroups, id:\.self) { muscleGroup in
                    Text(muscleGroup)
                }
            }
            Button("Add Exercise") {
                addExercise()
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(name=="")

        }
    }
    
    
    func addExercise(){
        let exercise = Exercise(type: exerciseType, name: name, mainMuscleGroup: mainMuscleGroup)
        _ = storage.addElementArray(storageKey: "exercises", element: exercise)
    }
}
