import SwiftUI

struct Home: View {
    var numberWorkouts = 0
    
    @ObservedObject var viewModel: ViewModel

    //@AppStorage("workouts") var workouts: [Workout] = []
    var body: some View {
        VStack{
            NavigationLink(destination: New_workout(),
                               label: {
                    Text("Add workout")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                })
            List(0..<viewModel.workouts.count, id: \.self) { index in
                NavigationLink(
                    destination: Workout_screen(viewModel: Workout_screen.ViewModel(workoutNumber: index)),
                    label: {
                        Text(viewModel.workouts[index].name)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                    })
                
            }
            NavigationLink(destination: FinishedWorkouts(),
                               label: {
                    Text("See workouts")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                })
            
            
        }
        .onAppear {
            viewModel.loadWorkouts()
        }
    }
}
