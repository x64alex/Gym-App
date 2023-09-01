import SwiftUI
import Charts

public struct WeekWorkoutTimeChart: View {
    let days = ["M","Tu","W","Th","F","Sa","Su"]
    var workoutTime: [Int]
    
    public init(workoutTime: [Int]){
        if(workoutTime.count != 7){
            print("Bad length")
            print(workoutTime)
            self.workoutTime = [0, 0, 0, 0, 0, 0, 0]
        }
        else{
            self.workoutTime = workoutTime
        }
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            Chart(Array(workoutTime.enumerated()), id: \.offset) { index, workout in
                BarMark(x: .value("Day", days[index]), y: .value("Time", workoutTime[index]))
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
}

struct WeekWorkoutTimeChart_Previews: PreviewProvider {
    static var previews: some View {
        WeekWorkoutTimeChart(workoutTime: [0, 0, 0, 0, 0, 40, 20])
    }
}
