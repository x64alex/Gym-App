import SwiftUI
import SharedFramework

extension AddExercise {
    class ViewModel: ObservableObject {
        private var storage: WorkoutStorage
        private var index: Int = 0
        @Published var name: String = ""
        @Published var exerciseType: String = AppConstants.exerciseTypes[0]
        @Published var mainMuscleGroup: String = AppConstants.muscleGroups[0]
        @Published var details: Bool = false
        @Published var isEditable: Bool = false
        
        
        init(storage: WorkoutStorage, exercise: Exercise? = nil, index: Int = 0) {
            self.storage = storage
            guard let exercise = exercise else {
                self.isEditable = true
                return
            }
            self.name = exercise.name
            self.exerciseType = AppConstants.exerciseTypes[0]
            self.mainMuscleGroup = exercise.mainMuscleGroup
            self.details = true
            self.index = index
        }

        func addExercise(){
            let exercise = Exercise(type: exerciseType, name: name, mainMuscleGroup: mainMuscleGroup)
            _ = storage.addElementArray(storageKey: "exercises", element: exercise)
        }
        
        
        func updateExercise(){
            let exercise = Exercise(type: exerciseType, name: name, mainMuscleGroup: mainMuscleGroup)
            _ = storage.updateElementAtIndex(storageKey: "exercises", index: index, newElement: exercise)
        }
    }
}
