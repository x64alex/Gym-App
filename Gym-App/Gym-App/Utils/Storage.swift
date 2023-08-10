import SwiftUI

class Storage: ObservableObject {
    
    func getDataArray<T: Decodable>(storageKey: String) -> [T]{
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
}
