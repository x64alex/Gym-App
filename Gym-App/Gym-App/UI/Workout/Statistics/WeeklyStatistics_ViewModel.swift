import Foundation
import SwiftUI
import SharedFramework

extension WeeklyStatisticsView {
    class ViewModel: ObservableObject {
        private var storage: WorkoutStorage
        @Published var workoutTimes: [Int] = [0, 0, 0, 0, 0, 0, 0]
        @Published var selectedDate: Date = Date().getFirstDayWeek(){
            didSet {
                modifyWorkoutTimes()
            }
        }
        
        init(storage: WorkoutStorage) {
            self.storage = storage
        }
        
        func modifyWorkoutTimes() {
            let calendar = Calendar.current
            let workouts: [Workout] = storage.getArray(storageKey: "doneworkouts")
            workoutTimes = []
            var weekDays: [Date: Int] = [:]
                    
            for weekDayIndex in 0 ..< 7 {
                let dayWeek = calendar.date(byAdding: .day, value: weekDayIndex, to: selectedDate) ?? selectedDate
                weekDays[dayWeek] = 0
            }
            
            for weekDayIndex in 0 ..< 7 {
                let dayWeek = calendar.date(byAdding: .day, value: weekDayIndex, to: selectedDate) ?? selectedDate
                
                for (workout) in workouts{
                    if(dayWeek.isSameDay(as: workout.startDate ?? Date())){
                        weekDays[dayWeek]! += workout.duration
                    }
                }
                
                workoutTimes.append(weekDays[dayWeek]!)
            }
        }

        func changeDateWeek(forward: Bool) {
            let calendar = Calendar.current
            var dateComponents = DateComponents()
            dateComponents.day = forward ? 7: -7
            selectedDate = calendar.date(byAdding: dateComponents, to: selectedDate) ?? selectedDate
        }
    
    }
}
