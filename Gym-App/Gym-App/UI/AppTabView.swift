import SwiftUI

struct AppTabView: View {
    @State private var selection = 0

    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                WorkoutHome(viewModel: WorkoutHome.ViewModel())
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Workouts")
                    }
                    .tag(0)
                LearnView()
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
                ProfileView()
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
                    .tag(3)
            }
            .accentColor(Colors.TabBar.tint)
            .toolbarBackground(Colors.TabBar.bar, for: .tabBar)
        }
    }
}
