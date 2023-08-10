import SwiftUI

struct Exercises: View {
    
    @State var name: String = ""
    
    
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
        var exercise = Exercise(name: name)
        
        if let data = UserDefaults.standard.data(forKey: "exercises") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                let encoder = JSONEncoder()

                // Decode Note
                var exercises = try decoder.decode([Exercise].self, from: data)
                
                exercises.append(exercise)
                
                let data = try encoder.encode(exercises)
                
                UserDefaults.standard.set(data, forKey: "exercises")

            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }else{
            var exercises = [exercise]
            
            do {
                let encoder = JSONEncoder()

                let data = try encoder.encode(exercises)
                
                UserDefaults.standard.set(data, forKey: "exercises")

            } catch {
                print("Unable to Encode Note (\(error))")
            }
        }
    }
}

struct Exercises_Previews: PreviewProvider {
    static var previews: some View {
        Exercises()
    }
}
