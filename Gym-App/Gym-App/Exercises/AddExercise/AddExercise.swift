import SwiftUI
import SharedFramework

struct AddExercise: View {
    @StateObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    var body: some View {
        VStack {
            let textfield = TextField("Enter exercise name", text: $viewModel.name)
            let textfield1 = TextField("Enter exercise type", text: $viewModel.exerciseType)
            let textfield2 = TextField("Enter exercise group", text: $viewModel.mainMuscleGroup)
            let picker1 = Picker(selection: $viewModel.exerciseType, label: Text("")) {
                ForEach(AppConstants.exerciseTypes, id:\.self) { exerciseType in
                    Text(exerciseType)
                }
            }
            let picker2 = Picker(selection: $viewModel.exerciseType, label: Text("")) {
                ForEach(AppConstants.muscleGroups, id:\.self) { muscleGroup in
                    Text(muscleGroup)
                }
            }
            if viewModel.isEditable{
                HStack(spacing: 10) {
                    Text("Name: ")
                    textfield
                }
                HStack(spacing: 10) {
                    Text("Type: ")
                    textfield1
                }
                HStack(spacing: 10) {
                    Text("Group: ")
                    textfield2
                }
            } else {
                Text("Name: "+viewModel.name)
                Text("Type: "+viewModel.exerciseType)
                Text("Group: "+viewModel.mainMuscleGroup)
            }
            if !viewModel.details {
                Button("Add Exercise") {
                    viewModel.addExercise()
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(viewModel.name=="")
            }
            else{
                if !viewModel.isEditable {
                    Button("Edit") {
                        viewModel.isEditable = true
                    }
                }else{
                    HStack{
                        Button("Save edit") {
                            viewModel.updateExercise()
                            viewModel.isEditable = false
                        }
                        Button("Cancel") {
                            viewModel.isEditable = false
                        }.foregroundColor(Color.red)
                    }
                }
            }
        }
    }
    

}
