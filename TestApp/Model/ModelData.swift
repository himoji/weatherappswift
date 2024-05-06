import Foundation

var cities: [City] = load()

func load<T: Decodable>() -> T {
    guard let jsonFileURL = getJSONFileURL() else {
        fatalError("JSON file URL is nil.")
    }
    
    do {
        let data = try Data(contentsOf: jsonFileURL)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Failed to load data from JSON file: \(error)")
    }
}

public func save() {
    DispatchQueue.global(qos: .background).async {
        guard let jsonFileURL = getJSONFileURL() else {
            print("JSON file URL is nil.")
            return
        }
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(cities)
            try data.write(to: jsonFileURL, options: .atomic)
        } catch {
            print("Error encoding city data: \(error)")
        }
    }
}

func getJSONFileURL() -> URL? {
    do {
        let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return documentsDirectory.appendingPathComponent("cityData.json")
    } catch {
        print("Failed to get documents directory: \(error)")
        return nil
    }
}

public func copyJSONFileToDocumentsDirectoryIfNeeded() {
    DispatchQueue.global(qos: .background).async {
        guard let jsonFileURL = getJSONFileURL() else {
            print("JSON file URL is nil.")
            return
        }
        
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: jsonFileURL.path) {
            guard let bundleJSONURL = Bundle.main.url(forResource: "cityData", withExtension: "json") else {
                print("cityData.json not found in app bundle.")
                return
            }
            
            do {
                try fileManager.copyItem(at: bundleJSONURL, to: jsonFileURL)
                print("cityData.json copied to documents directory.")
            } catch {
                print("Error copying cityData.json: \(error)")
            }
        }
    }
}
