import SwiftUI
import SharedFramework

struct StartWorkoutView: View {
    @EnvironmentObject private var storage: WorkoutStorage
    @StateObject var viewModel: ViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    @State private var currentId = 0
    
    var body: some View {
        VStack {
            Text(viewModel.workout.name)
            Text(viewModel.exercise.name)
            Spacer().frame(height: 40)
            HStack(spacing: 30) {
                VStack(spacing: 10) {
                    Text("Sets")
                    Text("\(viewModel.setIndex)/\(viewModel.exercise.getSets())")
                }
                VStack(spacing: 10) {
                    Text("Reps")
                    Picker(selection: $viewModel.exercise.repetitions[viewModel.setIndex-1].reps, label: Text("")) {
                        ForEach((1...50), id:\.self) { reps in
                            Text(String(reps))
                        }
                    }
                }
                VStack(spacing: 10) {
                    Text("Weight")
                    Picker(selection: $viewModel.exercise.repetitions[viewModel.setIndex-1].weight, label: Text("")) {
                        ForEach((0...50), id:\.self) { reps in
                            if(reps == 0){
                                Text("Bodyweight")
                            }
                            else{
                                Text(String(reps)+" kg")
                            }
                        }
                    }
                }
            }
            Spacer()
            if(!viewModel.finished){
                Button(viewModel.buttonText) {
                    viewModel.next()
                }
                .frame(width: 80, height: 80)
                .foregroundColor(Color.white)
                .background(Color.green)
                .cornerRadius(30)
            } else{
                Button("Finish") {
                    viewModel.doneWorkout()
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(width: 80, height: 80)
                .foregroundColor(Color.white)
                .background(Colors.finishWorkout)
                .cornerRadius(30)
            }
            Spacer().frame(height: 20)
            
        }
        .onAppear {
            // Subscribe to scenePhase changes
            NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { _ in
                viewModel.updateTimer()
            }
        }
    }
}
