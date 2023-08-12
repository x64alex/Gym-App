import SwiftUI

struct Workout_screen: View {
    @EnvironmentObject private var storage: Storage
    @StateObject var viewModel: ViewModel
    
    @State private var currentId = 0
    
    var body: some View {
        VStack {
            NavigationLink(destination: AddExerciseView(),
                               label: {
                    Text("Add exercise")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                })
            List(0..<viewModel.workout.exercises.count, id: \.self) { i in
                VStack(alignment: .leading,spacing:0){
                    HStack{
                        Text(viewModel.workout.exercises[i].name)
                        Text(String(viewModel.workout.exercises[i].getSets())+" sets")
                        Spacer()
                        Text(String(currentId==i))
                    }.onTapGesture {
                        currentId = i
                    }
                    if currentId == i{
                        ForEach(0..<viewModel.workout.exercises[i].getSets(), id: \.self) { j in
                            HStack(alignment: .bottom, spacing: 0) {
                                RepCell(
                                    rep: $viewModel.workout.exercises[i].repetitions[0].reps,
                                    weight: $viewModel.workout.exercises[i].repetitions[0].weight,
                                    setNumber: j+1
                                )
                             }.padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                         }
                    }

                }
            }
            Button("Finish workout", action: {
                viewModel.workout.date = Date()
                _ = storage.addElementArray(storageKey: "doneworkouts", element: viewModel.workout)
            })
            .onAppear {
                viewModel.loadWorkout()
            }
        }
    }
}
