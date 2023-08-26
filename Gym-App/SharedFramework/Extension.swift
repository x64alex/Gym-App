import Foundation

public extension Date {
    func getCurrentWeekDates() -> (start: Date, end: Date) {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
        
        return (startOfWeek, endOfWeek)
    }
    
    func getFirstDayWeek(european:Bool) -> Date {
        let calendar = Calendar.current
        let currentDate = Date()
        
        var day = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
        
        if european{
            return calendar.date(byAdding: .day, value: 1, to: day)!
        }
        return day
    }
    
    func isSameDay(as otherDate: Date, in timeZone: TimeZone = TimeZone(identifier: "UTC")!) -> Bool {
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        let components1 = calendar.dateComponents([.year, .month, .day], from: self)
        let components2 = calendar.dateComponents([.year, .month, .day], from: otherDate)
        
        return components1.year == components2.year &&
               components1.month == components2.month &&
               components1.day == components2.day
    }
}

public extension Int {
    func getStringTime() -> String {
        let hours: Int = self / 3600
        let minutes: Int = (self % 3600) / 60
        let seconds: Int = self % 60
        
        if hours > 0 {
            if minutes > 0 || seconds > 0 {
                return String(format: "%01dh %01dm %01ds", hours, minutes, seconds)
            } else {
                return String(format: "%01dh", hours)
            }
        } else if minutes > 0 {
            if seconds > 0 {
                return String(format: "%01dm %02ds", minutes, seconds)
            } else {
                return String(format: "%01dm", minutes)
            }
        } else {
            return String(format: "%01ds", seconds)
        }
    }
        func getStringHours() -> String {
            let hours: Int = self / 360
            
            if hours > 0 {
                if(hours % 10 == 0){
                    return String(format: "%01dh", hours/10)
                }
                return String(format: "%.1fh", Double(hours)/10)
            } else {
                return "0h"
            }
        }
    

}

