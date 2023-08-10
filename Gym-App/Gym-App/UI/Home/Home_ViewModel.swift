import Foundation

extension Home {
    class ViewModel: ObservableObject {
        @Published var workouts: [Workout] = []
        
                
        
        func loadWorkouts() {
            if let data = UserDefaults.standard.data(forKey: "workouts") {
                do {
                    // Create JSON Decoder
                    let decoder = JSONDecoder()

                    // Decode Note
                    workouts = try decoder.decode([Workout].self, from: data)
                    

                } catch {
                    print("Unable to Decode Note (\(error))")
                }
            }
        }
    }
}
