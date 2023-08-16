import WidgetKit
import SharedFramework
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> WorkoutEntry {
        WorkoutEntry(date: Date(), configuration: ConfigurationIntent(), workoutTime: [])
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WorkoutEntry) -> ()) {
        let entry = WorkoutEntry(date: Date(), configuration: configuration, workoutTime: [])
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [WorkoutEntry] = []

        let storage = WorkoutStorage()
        
        let workouts: [Workout] = storage.getArray(storageKey: "doneworkouts")
        
        let firstDayWeek = Date().getFirstDayWeek()
        let weekDays: [Date: Int] = [:]
        

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        for weekDay in 0 ..< 7 {
            
        }

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

    var body: some View {
        Text(entry.date, style: .time)
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
