import SwiftUI


struct Workout_screen: View {
    @Environment(\.scenePhase) var appState

    @StateObject var viewModel: ViewModel
    
    @State private var currentId = 0
    
    var body: some View {
        VStack {
            NavigationLink(destination: AddExerciseView(),
                               label: {
                    Text("Add exercise")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                })
            List(0..<viewModel.workout.exercises.count, id: \.self) { i in
                VStack(alignment: .leading,spacing:0){
                    HStack{
                        Text(viewModel.workout.exercises[i].name)
                        Text(viewModel.workout.exercises[i].getSets()+" sets")
                        Spacer()
                        Text(String(currentId==i))
                    }.onTapGesture {
                        currentId = i
                    }
                    if currentId == i{
                        ForEach(0..<viewModel.workout.exercises[i].sets, id: \.self) { j in
                            HStack(alignment: .bottom, spacing: 0) {
                                RepCell(
                                    rep: $viewModel.workout.exercises[i].repetitions[j].reps,
                                    weight: $viewModel.workout.exercises[i].repetitions[j].weight,
                                    setNumber: j+1
                                )

                                //RepCell(rep: $viewModel.workout.exercises[i].repetitions[j].reps, weight: $rep, setNumber: j+1)
                             }.padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                         }
                    }

                }
            }
            .onChange(of: appState) { newState in
                if newState == .active {
                    print("Active")
                } else if newState == .inactive {
                    print("InActive")
                } else if newState == .background {
                    print("Background")
                }
            }
            Button("Finish workout", action: {
                print(viewModel.workout)
                print("Workout finished")
                
                
                viewModel.workout.date = Date()
                if let data = UserDefaults.standard.data(forKey: "doneworkouts") {
                    do {
                        // Create JSON Decoder
                        let decoder = JSONDecoder()
                        let encoder = JSONEncoder()

                        // Decode Note
                        var workouts = try decoder.decode([Workout].self, from: data)
                        
                        workouts.append(viewModel.workout)
                        
                        let data = try encoder.encode(workouts)
                        
                        UserDefaults.standard.set(data, forKey: "doneworkouts")

                    } catch {
                        print("Unable to Decode Note (\(error))")
                    }
                }else{
                    var workouts = [viewModel.workout]
                    
                    do {
                        // Create JSON Encoder
                        let encoder = JSONEncoder()

                        // Encode Note
                        let data = try encoder.encode(workouts)
                        
                        UserDefaults.standard.set(data, forKey: "doneworkouts")

                    } catch {
                        print("Unable to Encode Note (\(error))")
                    }
                }
                
            })
            .onAppear {
                viewModel.loadWorkout()
            }
            
            
        }
    }
}
