import SwiftUI
import SharedFramework

struct Exercises: View {
    @State var name: String = ""
    @State private var searchText = ""

    @EnvironmentObject private var storage: WorkoutStorage
    
    @State var exercises: [Exercise] = []

    
    var body: some View {
        
        VStack(spacing:0){
            NavigationView {

            List(0..<filteredExercises.count, id: \.self) { index in
                Text(filteredExercises[index].name)
                .swipeActions {
                    Button("Remove") {
                        self.deleteExercise(index: index)
                    }
                    .tint(Colors.removeColor)
                }
                
            }
        }
               .searchable(text: $searchText)
            
            NavigationLink(destination: AddExercise(),
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
    
    func deleteExercise(index: Int) {
        exercises = storage.deleteElementAtIndex(storageKey: "exercises", index: index)
    }
}
