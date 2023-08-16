import SwiftUI
import SharedFramework

@main
struct Gym_AppApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var storage = WorkoutStorage()
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environmentObject(storage)
                .environmentObject(appState)
        }
    }
}
