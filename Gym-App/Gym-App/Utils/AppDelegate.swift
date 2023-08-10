
import UIKit
class AppDelegate1: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        // Return true if you want to save app state.
        return true
    }

    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        // Return true if you want to restore app state.
        return true
    }
}
