import SwiftUI

class Storage: ObservableObject {
    
    func addElementArray<T: Codable>(storageKey: String, element: T) -> Bool{
        
        if let data = UserDefaults.standard.data(forKey: storageKey) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                let encoder = JSONEncoder()

                var dataArray = try decoder.decode([T].self, from: data)
                dataArray.append(element)
                
                let data = try encoder.encode(dataArray)
                UserDefaults.standard.set(data, forKey: storageKey)
                
                return true
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }else {
            let dataArray:[T] = [element]

            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(dataArray)
                UserDefaults.standard.set(data, forKey: storageKey)
                
                return true
            } catch {
                print("Unable to Encode Note (\(error))")
            }
        }
        return false
    }
    
    func addArray<T: Codable>(storageKey: String, elements: [T]) -> Bool{
        
        if let data = UserDefaults.standard.data(forKey: storageKey) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                let encoder = JSONEncoder()

                var dataArray = try decoder.decode([T].self, from: data)
                dataArray.append(contentsOf: elements)
            
                let data = try encoder.encode(dataArray)
                UserDefaults.standard.set(data, forKey: storageKey)
                
                return true
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }else {
            let dataArray:[T] = elements

            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(dataArray)
                UserDefaults.standard.set(data, forKey: storageKey)
                
                return true
            } catch {
                print("Unable to Encode Note (\(error))")
            }
        }
        return false
    }
    
    
    func getArray<T: Decodable>(storageKey: String) -> [T]{
        var dataArray:[T] = []
        
        if let data = UserDefaults.standard.data(forKey: storageKey) {
            do {
                let decoder = JSONDecoder()
                dataArray = try decoder.decode([T].self, from: data)

            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return dataArray
    }
    
    func deleteElementAtIndex<T: Codable>(storageKey: String, index: Int) -> [T]{
        var dataArray:[T] = []
        
        if let data = UserDefaults.standard.data(forKey: storageKey) {
            do {
                let decoder = JSONDecoder()
                let encoder = JSONEncoder()

                dataArray = try decoder.decode([T].self, from: data)
                dataArray.remove(at: index)
                
                let data = try encoder.encode(dataArray)
                UserDefaults.standard.set(data, forKey: storageKey)
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return dataArray
    }
    
    func updateElementAtIndex<T: Codable>(storageKey: String, index: Int, newElement: T) -> [T]{
        var dataArray:[T] = []
        
        if let data = UserDefaults.standard.data(forKey: storageKey) {
            do {
                let decoder = JSONDecoder()
                let encoder = JSONEncoder()

                dataArray = try decoder.decode([T].self, from: data)
                if(index < dataArray.count){
                    dataArray[index] = newElement
                }
                let data = try encoder.encode(dataArray)
                UserDefaults.standard.set(data, forKey: storageKey)
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return dataArray
    }
}
