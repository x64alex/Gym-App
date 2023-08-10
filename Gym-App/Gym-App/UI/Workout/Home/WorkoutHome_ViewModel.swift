import Foundation

extension WorkoutHome {
    class ViewModel: ObservableObject {
        @Published var workouts: [Workout] = []
        
                
        
        func loadWorkouts() {
            if let data = UserDefaults.standard.data(forKey: "workouts") {
                do {
                    let decoder = JSONDecoder()

                    workouts = try decoder.decode([Workout].self, from: data)
                    

                } catch {
                    print("Unable to Decode Note (\(error))")
                }
            }
        }
    }
}
