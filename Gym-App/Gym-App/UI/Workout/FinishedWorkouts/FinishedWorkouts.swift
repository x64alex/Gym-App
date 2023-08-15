import SwiftUI

struct FinishedWorkouts: View {
    @StateObject var viewModel: ViewModel

    @EnvironmentObject private var storage: Storage


    
    var body: some View {
        VStack(spacing: 0) {
            DatePicker("Select Date", selection: $viewModel.selectedDate, displayedComponents: .date)
                      .padding(.horizontal)
            List(0..<viewModel.workouts.count, id: \.self) { index in
                HStack(spacing: 0) {
                    Text(viewModel.workouts[index].name)
                    Spacer()
                    Text(viewModel.workouts[index].duration.getStringTime())
                }
                    .background(
                        NavigationLink("",
                                destination: DoneWorkoutScreen(viewModel: DoneWorkoutScreen.ViewModel(workoutNumber: index, storage: storage))).opacity(0)
                    )
                 .swipeActions {
                    Button("Remove") {
                        viewModel.deleteWorkout(index: index)
                    }
                    .tint(Colors.removeColor)
                }
                
            }
            Spacer()
        }.onAppear {
            viewModel.loadWorkouts()
        }

    }
}
