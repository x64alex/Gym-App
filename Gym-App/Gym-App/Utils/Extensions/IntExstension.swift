import Foundation

extension Int {
    func getStringTime() -> String {
        let hours: Int = self / 3600
        let minutes: Int = (self % 3600) / 60
        let seconds: Int = self % 60
        
        if hours > 0 {
            return String(format: "%01dh %01dm %01ds", hours, minutes, seconds)
        } else if minutes > 0 {
            return String(format: "%01dm %02ds", minutes, seconds)
        } else {
            return String(format: "%01 ds", seconds)
        }
        
    }
}
