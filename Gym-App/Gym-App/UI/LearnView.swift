import SwiftUI

struct LearnView: View {
    var body: some View {
        VStack{
            Text("Learn")
                .font(.system(size: 30, weight: .bold, design: .rounded))
            Button("Clear workouts") {
                    UserDefaults.standard.removeObject(forKey: "doneworkouts")

            }
        }
    }
    
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
