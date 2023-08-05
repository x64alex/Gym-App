//
//  FinishedWorkouts.swift
//  Gym-App
//
//  Created by acantor on 01.08.2023.
//

import SwiftUI

struct FinishedWorkouts: View {
    @State var workouts: [Workout] = []
    
    
    var body: some View {
        ScrollView {
            if workouts.count == 0{
                Text("No workouts saved")
            }
            ForEach(workouts){el in
                Text(el.description)
            }
        }
        .onAppear(){
            if let data = UserDefaults.standard.data(forKey: "doneworkouts") {
                do {
                    // Create JSON Decoder
                    let decoder = JSONDecoder()

                    // Decode Note
                    self.workouts = try decoder.decode([Workout].self, from: data)
                    
                } catch {
                    print("Unable to Decode Note (\(error))")
                }
            }
        }
        Button("See trainigs") {

        }
    }
}

struct FinishedWorkouts_Previews: PreviewProvider {
    static var previews: some View {
        FinishedWorkouts()
    }
}
