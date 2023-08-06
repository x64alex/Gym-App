import SwiftUI

struct ContentView: View {
    @State private var selection = 0

    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                Home(viewModel: Home.ViewModel())
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Workouts")
                    }
                    .tag(0)
                
                VStack{
                    Text("Learn")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                    Button("Clear workouts") {                        
                            UserDefaults.standard.removeObject(forKey: "doneworkouts")

                    }
                }
                    .tabItem {
                        Image(systemName: "bookmark.circle.fill")
                        Text("Learn")
                    }
                    .tag(1)
                
                Exercises()
                    .tabItem {
                        Image(systemName: "video.circle.fill")
                        Text("Exercises")
                    }
                    .tag(2)
                
                Text("Profile Tab")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
                    .tag(3)
            }
            .accentColor(.red)
            .onAppear() {
                UITabBar.appearance().barTintColor = .white
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
