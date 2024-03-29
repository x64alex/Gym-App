import SwiftUI
import SharedFramework

struct LearnView: View {
    @EnvironmentObject private var storage: WorkoutStorage

    
    var body: some View {
        VStack(spacing:15){
            Text("Learn")
                .font(.system(size: 30, weight: .bold, design: .rounded))
            Button("Clear workouts") {
                    UserDefaults.standard.removeObject(forKey: "workouts")
            }
            Button("Clear done workouts") {
                UserDefaults.standard.removeObject(forKey: "doneworkouts")
            }
            Button("Clear exercises") {
                    UserDefaults.standard.removeObject(forKey: "exercises")
            }
            Button("Add exercises") {
                UserDefaults.standard.removeObject(forKey: "exercises")
                _ = storage.addArray(storageKey: "exercises", elements: AppConstants.exercises)
            }
            Button("Add workouts") {
                AppConstants.workouts.forEach { workout in
                    _ = storage.addElementArray(storageKey: "workouts", element: workout)
                }
            }
            NavigationLink(destination: ListFinishedWorkouts(),
                           label: {
                Text("See list workouts")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            })
            NavigationLink(destination: WeeklyStatisticsView(viewModel: WeeklyStatisticsView.ViewModel(storage: storage)),
                           label: {
                Text("See statistics workouts")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            })
        }
    }
    
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
