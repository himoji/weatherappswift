// MARK: - City Data Management

// This section of code deals with loading and saving city data

import Foundation

/// A struct representing a city with its name and location coordinates
public struct City {
  // ... (Add properties for city name and location coordinates)
}

// MARK: - Loading City Data

/// Fetches city data from the app bundle as a fallback mechanism.
public func getCitiesFromBundle() -> [City] {
  guard let filePath = Bundle.main.path(forResource: "cityData", ofType: "json") else {
    // Return an empty array if not found
    return []
  }

  do {
    let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
    let decoder = JSONDecoder()
    let cityData = try decoder.decode([City].self, from: data)
    return cityData
  } catch {
    print("Error decoding city data from app bundle: \(error)")
    return [] // Return an empty array on any error
  }
}

/// Attempts to load city data from the user's documents directory,
/// falling back to the app bundle if not found.
public func getCitiesFromUserDocuments() -> [City] {
  // 1. Check for user data in Documents directory
  let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  let filePath = documentsDirectory.appendingPathComponent("cityData.json")

  guard FileManager.default.fileExists(atPath: filePath.path) else {
    // No data found in user documents, fallback to bundle
    return getCitiesFromBundle()
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

// MARK: - Saving City Data

/// Saves an array of city objects to the user's documents directory.
public func saveCitiesToDocuments(_ cities: [City]) throws {
  let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  let filePath = documentsDirectory.appendingPathComponent("cityData.json")

  let encoder = JSONEncoder()
  encoder.outputFormatting = .prettyPrinted

  let data = try encoder.encode(cities)
  try data.write(to: filePath)
}

// MARK: - City Data Utilities

/// Copies the default "cityData.json" from the app bundle to the user's documents directory if it doesn't already exist.
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

/// Checks if a given city has identical coordinates to any city in the provided array.
public func hasIdenticalCoordinates(cities: [City], city1: City) -> Bool {
  for (_, city2) in cities.enumerated() {
    if city1.locationCoordinate.latitude == city2.locationCoordinate.latitude && city1.locationCoordinate.longitude == city2.locationCoordinate.longitude {
      return true
    }
  }
  return false
}
