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
                    Picker("Select reps",selection: $viewModel.exercise.repetitions[viewModel.setIndex-1].reps) {
                        ForEach(max(viewModel.exercise.repetitions[viewModel.setIndex-1].reps - 6, 1)...(viewModel.exercise.repetitions[viewModel.setIndex-1].reps + 20), id: \.self) { reps in
                            Text(String(reps))
                        }
                    }
                }
                VStack(spacing: 10) {
                    Text("Weight")
                    Picker("Select weight",selection: $viewModel.exercise.repetitions[viewModel.setIndex-1].weight) {
                        ForEach((0...50), id:\.self) { weight in
                            if(weight == 0){
                                Text("Bodyweight")
                            }
                            else{
                                Text(String(weight)+" kg")
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
                .foregroundColor(AppTheme.activeColorPalette.primaryText)
                .background(AppTheme.activeColorPalette.primary)
                .cornerRadius(30)
            } else{
                Button("Finish") {
                    viewModel.doneWorkout()
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(width: 80, height: 80)
                .foregroundColor(AppTheme.activeColorPalette.primaryText)
                .background(AppTheme.activeColorPalette.secondary)
                .cornerRadius(30)
            }
            Spacer().frame(height: 20)
            
        }
//        .background(AppTheme.activeColorPalette.background)
        .onAppear {
            // Subscribe to scenePhase changes
            NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { _ in
                viewModel.updateTimer()
            }
        }
    }
}
