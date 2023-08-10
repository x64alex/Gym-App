import SwiftUI

struct Exercises: View {
    @State var name: String = ""
    @EnvironmentObject private var storage: Storage
    
    @State var exercises: [Exercise] = []

    
    var body: some View {
        VStack(spacing:0){
            List(0..<exercises.count, id: \.self) { index in
                Text(exercises[index].name)
    //            NavigationLink(
    //                destination: Workout_screen(viewModel: Workout_screen.ViewModel(workoutNumber: index)),
    //                label: {
    //                    Text(viewModel.workouts[index].name)
    //                        .font(.system(size: 20, weight: .bold, design: .rounded))
    //                })
                .swipeActions {
                    Button("Remove") {
                        self.deleteExercise(index: index)
                    }
                    .tint(Colors.removeColor)
                }
                
            }
            
            NavigationLink(destination: AddExercise(),
                           label: {
                Text("Add exercise")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            })
            Text("exercise list")
        }
        .onAppear{
            exercises = storage.getArray(storageKey: "exercises")
        }
    }
    
    
    func deleteExercise(index: Int) {
        exercises = storage.deleteElementAtIndex(storageKey: "exercises", index: index)
    }
}
