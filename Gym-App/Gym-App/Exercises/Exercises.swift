import SwiftUI

struct Exercises: View {
    @State var name: String = ""
    @EnvironmentObject private var storage: Storage

    
    var body: some View {
        VStack {
            Text("Name").font(.headline)
            TextField("Enter exercise name", text: $name)
                .padding(.all)
                .background(Color(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, opacity: 0.7))
            Button("Add Exercise") {
                addExercise()
            }
            .disabled(name=="")
        }
    }
    
    
    func addExercise(){
        let exercise = Exercise(name: name)
        _ = storage.addElementArray(storageKey: "exercises", element: exercise)
    }
}
