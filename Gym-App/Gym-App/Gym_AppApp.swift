import SwiftUI

@main
struct Gym_AppApp: App {
    //@UIApplicationDelegateAdaptor(AppDelegate1.self) var appDelegate
    @StateObject var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                //.onContinueUserActivity(/* Handle user activity restoration if needed */)
                .onOpenURL(perform: { url in
                    // Handle URL restoration if needed
                })
        }
        .commands {
            // Add custom menu commands if needed
        }
        //.onContinueUserActivity(/* Handle user activity restoration if needed */)
        //.onOpenURL(perform: { url in
            // Handle URL restoration if needed
        
    }
}
