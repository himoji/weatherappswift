import Foundation

var cities: [City] = getCitiesFromBundle()

func getCitiesFromBundle() -> [City] {
      // 1. Fallback to app bundle
      guard let filePath = Bundle.main.path(forResource: "cityData", ofType: "json") else {
           return [] // Return empty array if not found in either location
          }
       
      do {
           let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
           let decoder = JSONDecoder()
           let cityData = try decoder.decode([City].self, from: data)
          return cityData
         } catch {
              print("Error decoding city data from app bundle: \(error)")
              return [] // Return empty array on any error
            }
}

public func getCitiesFromUserDocuments() -> [City] {
  // 1. Check for user data in Documents directory
  let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  let filePath = documentsDirectory.appendingPathComponent("cityData.json")

  guard FileManager.default.fileExists(atPath: filePath.path) else {
    // No data found in user documents, fallback to bundle (optional)
    return getCitiesFromBundle() // Call the original function (optional)
  }

  do {
    let data = try Data(contentsOf: filePath)
    let decoder = JSONDecoder()
    let cityData = try decoder.decode([City].self, from: data)
    return cityData
  } catch {
    print(error)
      return []
  }
}

public func saveCitiesToDocuments(_ cities: [City]) throws {
  let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  let filePath = documentsDirectory.appendingPathComponent("cityData.json")

  let encoder = JSONEncoder()
  encoder.outputFormatting = .prettyPrinted

  let data = try encoder.encode(cities)
  try data.write(to: filePath)
}


public func copyCityDataToDocuments() -> Bool {
  guard let filePath = Bundle.main.path(forResource: "cityData", ofType: "json") else {
    print("cityData.json not found in app bundle")
    return false
  }
  
  guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
    print("Failed to get documents directory URL")
    return false
  }
  
  let fileURL = documentsDirectory.appendingPathComponent("cityData.json")
  
  do {
    if !FileManager.default.fileExists(atPath: fileURL.path) {
      try FileManager.default.copyItem(atPath: filePath, toPath: fileURL.path)
      print("cityData.json copied to documents directory")
    } else {
      print("cityData.json already exists in documents directory")
    }
    return true
  } catch {
    print("Error copying cityData.json: \(error)")
    return false
  }
}

public func hasIdenticalCoordinates(cities: [City], city1: City) -> Bool {
    for (_, city2) in cities.enumerated() {
        if city1.locationCoordinate.latitude == city2.locationCoordinate.latitude && city1.locationCoordinate.longitude == city2.locationCoordinate.longitude {
            return true
        }
    }
  return false
}
