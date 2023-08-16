import Foundation

public extension Date {
    func getCurrentWeekDates() -> (start: Date, end: Date) {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
        
        return (startOfWeek, endOfWeek)
    }
    
    func getFirstDayWeek() -> Date {
        let calendar = Calendar.current
        let currentDate = Date()
        
        return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
    }
}
