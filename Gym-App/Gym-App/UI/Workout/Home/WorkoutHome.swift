import SwiftUI

struct WorkoutHome: View {
    var numberWorkouts = 0
    @StateObject var viewModel: ViewModel
    @EnvironmentObject private var storage: Storage

    @EnvironmentObject private var appState: AppState
    @SceneStorage("isDetailViewActive") private var isDetailViewActive: Bool = false

    var body: some View {
        NavigationView {
            VStack{
                NavigationLink(destination: AddWorkoutView(),
                               label: {
                    Text("Add workout")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                })
                List(0..<viewModel.workouts.count, id: \.self) { index in
                    NavigationLink(
                        destination: Workout_screen(viewModel: Workout_screen.ViewModel(workoutNumber: index, storage: storage)),
                        label: {
                            Text(viewModel.workouts[index].name)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                        })
                    .swipeActions {
                        Button("Remove") {
                            viewModel.deleteWorkout(index: index)
                        }
                        .tint(Colors.removeColor)
                    }
                    
                }
                NavigationLink(destination: FinishedWorkouts(viewModel: FinishedWorkouts.ViewModel(storage: storage)),
                               label: {
                    Text("See workouts")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                })

            }
            .onAppear {
                viewModel.loadWorkouts()
            }
        }
        .onChange(of: isDetailViewActive) { newValue in
            // Update the appState's isDetailViewActive whenever it changes.
            appState.isDetailViewActive = newValue
        }
    }
    
    private func isActive(_ index: Int) -> Binding<Bool> {
        Binding<Bool>(
            get: { appState.isDetailViewActive && isDetailViewActive },
            set: { newValue in
                isDetailViewActive = newValue
                appState.isDetailViewActive = newValue
            }
        )
    }
}
