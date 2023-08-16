import WidgetKit
import SharedFramework
import SwiftUI
import Intents
import Charts

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> WorkoutEntry {
        WorkoutEntry(date: Date(), configuration: ConfigurationIntent(), workoutTime: [0, 0, 0, 0, 0, 0, 0])
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WorkoutEntry) -> ()) {
        let entry = WorkoutEntry(date: Date(), configuration: configuration, workoutTime: [0, 0, 0, 0, 0, 0, 0])
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [WorkoutEntry] = []

        let storage = WorkoutStorage()
        let calendar = Calendar.current
        
        let workouts: [Workout] = storage.getArray(storageKey: "doneworkouts")
        
        let firstDayWeek = Date().getFirstDayWeek(european: true)
        var weekDays: [Date: Int] = [:]
        

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        for weekDayIndex in 0 ..< 7 {
            let dayWeek = calendar.date(byAdding: .day, value: weekDayIndex, to: firstDayWeek) ?? firstDayWeek
            weekDays[dayWeek] = 0
        }
        var workoutTimes: [Int] = []

        
        for weekDayIndex in 0 ..< 7 {
            let dayWeek = calendar.date(byAdding: .day, value: weekDayIndex, to: firstDayWeek) ?? firstDayWeek
            
            for (workout) in workouts{
                if(dayWeek.isSameDay(as: workout.startDate ?? Date())){
                    weekDays[dayWeek]! += workout.duration
                }
            }
            
            workoutTimes.append(weekDays[dayWeek]!)
        }

        entries.append(WorkoutEntry(date: Date(), configuration: configuration, workoutTime: workoutTimes))

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
        
    }
}

struct WorkoutEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    
    // workout time in order from monday to friday
    let workoutTime: [Int]
}

struct AppWidgetEntryView : View {
    var entry: Provider.Entry
    
    let days = ["M","T","W","T","F","S","S"]
    
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.width < 150 {
                Text("Small Widget")
                    .foregroundColor(.red)
            } else {
                HStack(spacing: 0) {
                    Spacer()
                    VStack(spacing: 0) {
                        Chart(Array(entry.workoutTime.enumerated()), id: \.offset){ index, workout in
                                BarMark(x: .value("Day", days[index]), y: .value("Time", entry.workoutTime[index]))
                                .foregroundStyle(Color.red.gradient)
                                .cornerRadius(10)
                        }
                        .chartYScale(domain: 0...7200)
                        .chartYAxis {
                            AxisMarks(values: [0, 1800, 3600, 7200]) {
                            let value = $0.as(Int.self)!
                            AxisValueLabel {
                                Text(value.getStringTime())
                            }
                        }
                     }
                    }
                    .frame(width: geometry.size.width*0.8, height: geometry.size.height*0.8)
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height)

            }
        }
        

    }
}

struct WorkoutWidget: Widget {
    let kind: String = "AppWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            AppWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct AppWidget_Previews: PreviewProvider {
    static var previews: some View {
        AppWidgetEntryView(entry: WorkoutEntry(date: Date(), configuration: ConfigurationIntent(), workoutTime: []))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
