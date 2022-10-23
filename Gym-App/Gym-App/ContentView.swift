import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                List(1...10, id: \.self) { index in
                    NavigationLink(
                        destination: Workout_screen(),
                        label: {
                            Text("Item #\(index)")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                        })
                    
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Workouts")
                }
                .tag(0)
                
                Text("Learn")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "bookmark.circle.fill")
                        Text("Learn")
                    }
                    .tag(1)
                
                Text("Video Tab")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "video.circle.fill")
                        Text("Video")
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