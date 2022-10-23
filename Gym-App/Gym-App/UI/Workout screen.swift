import SwiftUI


struct Workout_screen: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            NavigationLink(destination: New_workout(),
                               label: {
                    Text("Add exercise")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                })
            List(viewModel.exercies) { exercise in
                HStack{
                    Text(exercise.name)
                    Text(exercise.getSets())
                }
            }
            .onAppear {
                viewModel.loadCountries()
            }
            
        }
    }
}
