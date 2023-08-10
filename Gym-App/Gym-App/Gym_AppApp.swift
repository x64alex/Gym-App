import SwiftUI

@main
struct Gym_AppApp: App {
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environmentObject(appState)
        }
    }
}
