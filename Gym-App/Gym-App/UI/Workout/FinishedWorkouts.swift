import SwiftUI

struct FinishedWorkouts: View {
    @EnvironmentObject private var storage: Storage
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

struct FinishedWorkouts_Previews: PreviewProvider {
    static var previews: some View {
        FinishedWorkouts()
    }
}
