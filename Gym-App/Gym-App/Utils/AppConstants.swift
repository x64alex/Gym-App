import Foundation

enum AppConstants {
    static let exerciseTypes = [
        "Aerobic & Cardio",
        "Strength",
        "Stretching",
        "Balance"
    ]
    static let muscleGroups = [
        "Chest",
        "Back",
        "Triceps",
        "Biceps",
        "Abs",
        "Delts"
    ]
    
    static let exercises = [
        Exercise(type: "Strength", name: "Corkscrew", mainMuscleGroup: "Abs"),
        Exercise(type: "Strength", name: "Hanging Leg Raise", mainMuscleGroup: "Abs"),
        Exercise(type: "Strength", name: "Russian Twists", mainMuscleGroup: "Delts"),
        Exercise(type: "Strength", name: "Plank", mainMuscleGroup: "Abs"),
        Exercise(type: "Strength", name: "Crunches", mainMuscleGroup: "Abs"),
        Exercise(type: "Strength", name: "Sit-ups", mainMuscleGroup: "Abs"),
        Exercise(type: "Strength", name: "Leg drops", mainMuscleGroup: "Abs"),
        
    ]
}
