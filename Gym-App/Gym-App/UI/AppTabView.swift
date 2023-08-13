import SwiftUI

struct AppTabView: View {
    @State private var selection = 0
    @EnvironmentObject private var storage: Storage

    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                WorkoutHome(viewModel: WorkoutHome.ViewModel(storage: storage))
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
//                ProfileView()
//                    .tabItem {
//                        Image(systemName: "person.crop.circle")
//                        Text("Profile")
//                    }
//                    .tag(3)
            }
            .accentColor(Colors.TabBar.tint)
            .toolbarBackground(Colors.TabBar.bar, for: .tabBar)
        }
    }
}
