import SwiftUI

extension Workout_screen {
    class ViewModel: ObservableObject {
        @Published private(set) var exercies: [Exercise] = []
                
        func loadCountries() {
            exercies.append(Exercise(sets: 1, name: "Lat pulldown"))
        }
    }
}
