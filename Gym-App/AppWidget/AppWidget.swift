import WidgetKit
import SharedFramework
import SwiftUI
import Intents
import Charts

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> WorkoutEntry {
        WorkoutEntry(date: Date(),
                     configuration: ConfigurationIntent(),
                     workoutTime: [0, 0, 0, 0, 0, 0, 0],
                     weekTime: 0,
                     dayTime: 0)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WorkoutEntry) -> ()) {
        let entry = WorkoutEntry(date: Date(),
                                 configuration: ConfigurationIntent(),
                                 workoutTime: [0, 0, 0, 0, 0, 0, 0],
                                 weekTime: 0,
                                 dayTime: 0)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [WorkoutEntry] = []
        let storage = WorkoutStorage()
        let calendar = Calendar.current
        let workouts: [Workout] = storage.getArray(storageKey: "doneworkouts")
        
        let firstDayWeek = Date().getFirstDayWeek(european: true)
        var weekDays: [Date: Int] = [:]
        
        var totalDay: Int = 0
        
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
            if(dayWeek.isSameDay(as: Date())){
                totalDay = weekDays[dayWeek]!
            }
            
            workoutTimes.append(weekDays[dayWeek]!)
        }

        entries.append(WorkoutEntry(date: Date(),
                                    configuration: configuration,
                                    workoutTime: workoutTimes,
                                    weekTime: workoutTimes.reduce(0, +),
                                    dayTime: totalDay
                                   ))

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
        
    }
}

struct WorkoutEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    
    // workout time in order from monday to friday
    let workoutTime: [Int]
    let weekTime: Int
    let dayTime: Int
}

struct AppWidgetEntryView : View {
    var entry: Provider.Entry
    
    let days = ["M","Tu","W","Th","F","Sa","Su"]
    
    
    @ViewBuilder
    func WorkoutTimeChartView(entry: WorkoutEntry, days: [String]) -> some View {
        VStack(spacing: 0) {
            Chart(Array(entry.workoutTime.enumerated()), id: \.offset) { index, workout in
                BarMark(x: .value("Day", days[index]), y: .value("Time", entry.workoutTime[index]))
                    .foregroundStyle(AppTheme.activeColorPalette.primary)
                    .cornerRadius(10)
            }
            .chartXAxis {
                AxisMarks(values: days) { value in
                    let formattedValue = value.as(String.self) ?? ""
                    if(formattedValue=="M"){
                        AxisGridLine()
                            .foregroundStyle(AppTheme.activeColorPalette.secondaryText.opacity(0.3))
                    }
                    AxisValueLabel {
                        Text(formattedValue)
                            .foregroundColor(AppTheme.activeColorPalette.secondaryText)
                    }
                }
            }
            .chartYScale(domain: 0...7200)
            .chartYAxis {
                AxisMarks(values: [0, 3600, 7200]) { value in
                    let formattedValue = value.as(Int.self) ?? 0
                    AxisValueLabel {
                        Text(formattedValue.getStringHours())
                            .foregroundColor(AppTheme.activeColorPalette.secondaryText)
                    }
                }
            }
        }
    }

    var body: some View {
        GeometryReader { geometry in
            //TODO: 200 is hardcoded change to iphone width
            if geometry.size.width < 200 {
                HStack(spacing: 0) {
                    WeekWorkoutTimeChart(workoutTime: entry.workoutTime)
                        .frame(width: geometry.size.width*0.9, height: geometry.size.height*0.8)
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                
                
            } else {
                HStack(alignment: .center, spacing: 0) {
                    Spacer()
                    VStack(alignment: .center, spacing: 0) {
                        Text("This week \(entry.weekTime.getStringHours())")
                            .font(.subheadline)
                            .foregroundColor(AppTheme.activeColorPalette.primary)
                        Text("Today \(entry.dayTime.getStringHours())")
                            .font(.subheadline)
                            .foregroundColor(AppTheme.activeColorPalette.primary)
                    }
                    .padding()
                    .background(AppTheme.activeColorPalette.background)
                    .cornerRadius(8)
                    .shadow(color: AppTheme.activeColorPalette.backgroundShadow.opacity(0.1), radius: 5, x: 0, y: 2)

                    Spacer()
                    WeekWorkoutTimeChart(workoutTime: entry.workoutTime)
                        .frame(width: geometry.size.width*0.5, height: geometry.size.height*0.8)
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)

            }
        }
        .background(AppTheme.activeColorPalette.background)

        

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
        AppWidgetEntryView(entry: WorkoutEntry(date: Date(),
                                               configuration: ConfigurationIntent(),
                                               workoutTime: [200, 100, 50, 0, 0, 0, 0],
                                               weekTime: 120,
                                               dayTime: 6320))
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
