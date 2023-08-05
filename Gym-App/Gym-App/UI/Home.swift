import SwiftUI

struct Home: View {
    var numberWorkouts = 0
    //@AppStorage("workouts") var workouts: [Workout] = []
    var body: some View {
        VStack{
            NavigationLink(destination: New_workout(),
                               label: {
                    Text("Add")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                })
            List(0...10, id: \.self) { index in
                NavigationLink(
                    destination: Workout_screen(viewModel: Workout_screen.ViewModel()),
                    label: {
                        Text("Item #\(index)")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                    })
                
            }
            NavigationLink(destination: FinishedWorkouts(),
                               label: {
                    Text("See workouts")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                })
            
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
