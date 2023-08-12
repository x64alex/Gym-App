import SwiftUI

struct LearnView: View {
    @EnvironmentObject private var storage: Storage

    
    var body: some View {
        VStack{
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
        }
    }
    
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
