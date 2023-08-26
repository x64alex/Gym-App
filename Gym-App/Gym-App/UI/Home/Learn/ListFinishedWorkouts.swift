import SwiftUI
import SharedFramework

struct ListFinishedWorkouts: View {
    @EnvironmentObject private var storage: WorkoutStorage
    @State var workouts: [Workout] = []
    
    
    var body: some View {
        ScrollView {
            if workouts.count == 0{
                Text("No workouts saved")
            }
            ForEach(workouts){el in
                Text(el.description)
            }
        }
        .onAppear(){
            self.workouts = storage.getArray(storageKey: "doneworkouts")
        }
    }
}
