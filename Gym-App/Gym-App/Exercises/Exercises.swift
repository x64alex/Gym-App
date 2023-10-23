import SwiftUI
import SharedFramework

struct Exercises: View {
    @State var name: String = ""
    @State private var searchText = ""

    @EnvironmentObject private var storage: WorkoutStorage
    
    @State var exercises: [Exercise] = []
    @State var deleteIndex = 0
    @State private var showAlert = false

    
    var body: some View {
        
        VStack(spacing:0){

            List(0..<filteredExercises.count, id: \.self) { index in
                NavigationLink(destination: AddExercise(viewModel: AddExercise.ViewModel(storage: storage, exercise: filteredExercises[index], index: index)),
                               label: {
                    Text(filteredExercises[index].name)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                })
                .swipeActions {
                    Button("Remove") {
                        showAlert = true
                        deleteIndex = index
                    }
                    .tint(Colors.removeColor)
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Delete Confirmation"),
                        message: Text("Are you sure you want to delete this exercise?"),
                        primaryButton: .destructive(Text("Delete")) {
                            self.deleteExercise(exercise: filteredExercises[deleteIndex])
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
               .searchable(text: $searchText)
            
            NavigationLink(destination: AddExercise(viewModel: AddExercise.ViewModel(storage: storage)),
                           label: {
                Text("Add exercise")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            })
        }
        .onAppear{
            exercises = storage.getArray(storageKey: "exercises")
        }
    }
    
    var filteredExercises: [Exercise] {
        if searchText.isEmpty {
            return exercises
        } else {
            return exercises.filter { $0.name.contains(searchText) }
        }
    }
    
    func deleteExercise(exercise: Exercise) {
        exercises = storage.deleteElement(storageKey: "exercises", element: exercise)
    }
}
