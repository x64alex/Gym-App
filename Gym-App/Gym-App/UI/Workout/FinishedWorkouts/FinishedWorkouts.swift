import SwiftUI
import SharedFramework

struct FinishedWorkouts: View {
    @StateObject var viewModel: ViewModel
    @EnvironmentObject private var storage: WorkoutStorage
    
    var body: some View {
        VStack(spacing: 0) {
            DatePicker("Select Date", selection: $viewModel.selectedDate, displayedComponents: .date)
                      .padding(.horizontal)
            List($viewModel.workouts) { $workout in
                HStack(spacing: 0) {
                    Text(workout.name)
                    Spacer()
                    Text(workout.duration.getStringTime())
                }
                    .background(
                        NavigationLink("",
                                destination: DoneWorkoutScreen(viewModel: DoneWorkoutScreen.ViewModel(workoutNumber: 0, storage: storage))).opacity(0)
                    )
                 .swipeActions {
                    Button("Remove") {
                        viewModel.deleteWorkout(workout: workout)
                    }
                    .tint(Colors.removeColor)
                }
                
            }
            Spacer()
        }.onAppear {
            viewModel.loadWorkouts()
        }.gesture(swipeGesture)

    }
    
    var swipeGesture: some Gesture {
        DragGesture(minimumDistance: 20, coordinateSpace: .local)
            .onEnded { value in
                if value.translation.width < 0 {
                    self.changeDate(forward: true)
                } else if value.translation.width > 0 {
                    self.changeDate(forward: false)
                }
            }
    }

    
    func changeDate(forward: Bool) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = forward ? 7: -7
        print("date1 \(viewModel.selectedDate)")
        viewModel.selectedDate = calendar.date(byAdding: dateComponents, to: viewModel.selectedDate) ?? viewModel.selectedDate
        print("date2 \(viewModel.selectedDate)")
    }
}
