import Foundation
import SharedFramework


struct identifablePicker: Identifiable {
    let id = UUID()
    let username: String
}

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
        
        Exercise(type: "Strength", name: "Assisted pull ups", mainMuscleGroup: "Back"),
        Exercise(type: "Strength", name: "Lat pulldowns", mainMuscleGroup: "Back"),
        Exercise(type: "Strength", name: "Low Row", mainMuscleGroup: "Back"),
        Exercise(type: "Strength", name: "Triangle Pull", mainMuscleGroup: "Back"),
        Exercise(type: "Strength", name: "Hammer Curls", mainMuscleGroup: "Biceps")
    ]
    
    static let workouts = [
        Workout(name: "Back Training", exercises: [
            Exercise(sets:3, type: "Strength", name: "Assisted pull ups", mainMuscleGroup: "Back"),
            Exercise(sets:4, type: "Strength", name: "Lat pulldowns", mainMuscleGroup: "Back"),
            Exercise(sets:4, type: "Strength", name: "Low Row", mainMuscleGroup: "Back"),
            Exercise(sets:3, type: "Strength", name: "Triangle Pull", mainMuscleGroup: "Back"),
            Exercise(sets:3, type: "Strength", name: "Hammer Curls", mainMuscleGroup: "Biceps")
        ]),
        Workout(name: "Chest Training", exercises: [
            Exercise(sets:4, type: "Strength", name: "Benchpress", mainMuscleGroup: "Chest"),
            Exercise(sets:3, type: "Strength", name: "Incline dumbell press", mainMuscleGroup: "Chest"),
            Exercise(sets:4, type: "Strength", name: "Chest Fly", mainMuscleGroup: "Chest"),
            Exercise(sets:4, type: "Strength", name: "Dumbbell shoulder press", mainMuscleGroup: "Delts"),
            Exercise(sets:4, type: "Strength", name: "Cable pull Downs", mainMuscleGroup: "Triceps")
        ]),
        Workout(name: "Benidorm abs", exercises: [
            Exercise(sets: 4, type: "Strength", name: "Leg drops", mainMuscleGroup: "Abs"),
            Exercise(sets: 4, type: "Strength", name: "Crunches", mainMuscleGroup: "Abs")
        ]),
        Workout(name: "Daily pushups", exercises: [
            Exercise(sets: 3, type: "Strength", name: "Push Ups", mainMuscleGroup: "Chest"),
        ])
        
    ]
}
