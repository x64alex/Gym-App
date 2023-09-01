import SwiftUI
import SharedFramework

struct WeeklyStatisticsView: View {
    @StateObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(){
            DatePicker("Select Date", selection: $viewModel.selectedDate, displayedComponents: .date)
                      .padding(.horizontal)
            //Text(viewModel.workoutTimes.map{(val)-> String in return String(val)}.joined(separator: ", "))
            WeekWorkoutTimeChart(workoutTime: viewModel.workoutTimes)
                .padding(EdgeInsets(top: 10, leading: 20, bottom:0, trailing: 20))
            VStack(alignment: .center, spacing: 0) {
                Text("Workout time: \(viewModel.workoutTimes.reduce(0,+).getStringTime())")
                    .font(.subheadline)
                    .foregroundColor(AppTheme.activeColorPalette.primary)
            }
            .padding()
            .background(AppTheme.activeColorPalette.background)
            .cornerRadius(8)
            .shadow(color: AppTheme.activeColorPalette.backgroundShadow.opacity(0.1), radius: 5, x: 0, y: 2)
            Spacer().frame(minHeight: 200)
        }.gesture(swipeGesture)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button("Back"){self.presentationMode.wrappedValue.dismiss()})
            .onAppear{
                viewModel.modifyWorkoutTimes()
            }
    }
    
    var swipeGesture: some Gesture {
        DragGesture(minimumDistance: 20, coordinateSpace: .local)
            .onEnded { value in
                if value.translation.width < 0 {
                    viewModel.changeDateWeek(forward: true)
                } else if value.translation.width > 0 {
                    viewModel.changeDateWeek(forward: false)
                }
            }
    }
    
    
}

struct WeeklyStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyStatisticsView(viewModel: WeeklyStatisticsView.ViewModel(storage: WorkoutStorage()))
    }
}
