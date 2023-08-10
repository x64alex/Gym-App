import SwiftUI

@main
struct Gym_AppApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var storage = Storage()
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environmentObject(storage)
                .environmentObject(appState)
        }
    }
}
