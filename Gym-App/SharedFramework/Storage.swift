import SwiftUI

public class WorkoutStorage: ObservableObject {
    
    let sharedDefaults: UserDefaults
    
    public init(){
        sharedDefaults = UserDefaults(suiteName: "group.cantor.gym.shared")!
    }
    
    public func addElementArray<T: Codable>(storageKey: String, element: T) -> Bool{
        
        if let data = sharedDefaults.data(forKey: storageKey) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                let encoder = JSONEncoder()

                var dataArray = try decoder.decode([T].self, from: data)
                dataArray.append(element)
                
                let data = try encoder.encode(dataArray)
                sharedDefaults.set(data, forKey: storageKey)
                
                return true
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }else {
            let dataArray:[T] = [element]

            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(dataArray)
                sharedDefaults.set(data, forKey: storageKey)
                
                return true
            } catch {
                print("Unable to Encode Note (\(error))")
            }
        }
        return false
    }
    
    public func addArray<T: Codable>(storageKey: String, elements: [T]) -> Bool{
        
        if let data = sharedDefaults.data(forKey: storageKey) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                let encoder = JSONEncoder()

                var dataArray = try decoder.decode([T].self, from: data)
                dataArray.append(contentsOf: elements)
            
                let data = try encoder.encode(dataArray)
                sharedDefaults.set(data, forKey: storageKey)
                
                return true
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }else {
            let dataArray:[T] = elements

            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(dataArray)
                sharedDefaults.set(data, forKey: storageKey)
                
                return true
            } catch {
                print("Unable to Encode Note (\(error))")
            }
        }
        return false
    }
    
    
    public func getArray<T: Decodable>(storageKey: String) -> [T]{
        var dataArray:[T] = []
        
        if let data = sharedDefaults.data(forKey: storageKey) {
            do {
                let decoder = JSONDecoder()
                dataArray = try decoder.decode([T].self, from: data)

            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return dataArray
    }
    
    public func deleteElementAtIndex<T: Codable>(storageKey: String, index: Int) -> [T]{
        var dataArray:[T] = []
        
        if let data = sharedDefaults.data(forKey: storageKey) {
            do {
                let decoder = JSONDecoder()
                let encoder = JSONEncoder()

                dataArray = try decoder.decode([T].self, from: data)
                dataArray.remove(at: index)
                
                let data = try encoder.encode(dataArray)
                sharedDefaults.set(data, forKey: storageKey)
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return dataArray
    }
    
    public func deleteElement<T: Codable & Equatable>(storageKey: String, element: T) -> [T]{
        let allElements: [T] = self.getArray(storageKey: storageKey)
        for index in 0..<allElements.count {
            if(allElements[index] == element){
                return self.deleteElementAtIndex(storageKey: storageKey, index: index)
            }
        }
        return allElements
    }

    
    public func updateElementAtIndex<T: Codable>(storageKey: String, index: Int, newElement: T) -> [T]{
        var dataArray:[T] = []
        
        if let data = sharedDefaults.data(forKey: storageKey) {
            do {
                let decoder = JSONDecoder()
                let encoder = JSONEncoder()

                dataArray = try decoder.decode([T].self, from: data)
                if(index < dataArray.count){
                    dataArray[index] = newElement
                }
                let data = try encoder.encode(dataArray)
                sharedDefaults.set(data, forKey: storageKey)
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return dataArray
    }
    
    public func getJSON(storageKey: String) -> String {
        guard let data = sharedDefaults.data(forKey: storageKey) else{
            return ""
        }
        
        
        if let jsonString = String(data: data, encoding: .utf8) {
            return jsonString
        } else {
            return ""
        }
    }

}
