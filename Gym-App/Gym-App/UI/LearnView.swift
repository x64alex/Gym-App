import SwiftUI

struct LearnView: View {
    @EnvironmentObject private var storage: Storage

    
    var body: some View {
        VStack(spacing:10){
            Text("Learn")
                .font(.system(size: 30, weight: .bold, design: .rounded))
            Button("Clear workouts") {
                    UserDefaults.standard.removeObject(forKey: "doneworkouts")
                    UserDefaults.standard.removeObject(forKey: "workouts")
            }
            Button("Clear exercises") {
                    UserDefaults.standard.removeObject(forKey: "exercises")
            }
            Button("Add exercises") {
                UserDefaults.standard.removeObject(forKey: "exercises")
                _ = storage.addArray(storageKey: "exercises", elements: AppConstants.exercises)
            }
            Button("Add workouts") {
                _ = storage.addElementArray(storageKey: "workouts", element: AppConstants.workouts[0])
            }
            NavigationLink(destination: ListFinishedWorkouts(),
                           label: {
                Text("See list workouts")
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
