import Foundation

// MARK: - Weather Data Fetching

class WeatherFetcher {

  // MARK: - API Configuration

  static let cacheExpirationTime: TimeInterval = 4 * 60 * 60 // 4 hours in seconds
  static let apiURL = "https://api.openweathermap.org/data/2.5/forecast"

  // MARK: - Fetching Weather Data

  static func getInfo(locationCoordinate: (latitude: Double, longitude: Double), completion: @escaping (Result<WeatherData, Error>) -> Void) {
    let cachedData = loadFromCache(locationCoordinate: locationCoordinate)
    if let cachedWeatherData = cachedData, !isCacheExpired(weatherData: cachedWeatherData) {
      completion(.success(cachedWeatherData))
      return
    }

    fetchFromAPI(locationCoordinate: locationCoordinate, completion: completion)
  }

  // MARK: - Cache Management

  private static func isCacheExpired(weatherData: WeatherData) -> Bool {
      print("[CHECK]: Is cache exprired")
    guard let timestamp = weatherData.list.first?.dt else { return true }
    return Date().timeIntervalSince1970 - TimeInterval(timestamp) >= cacheExpirationTime
  }

  private static func loadFromCache(locationCoordinate: (latitude: Double, longitude: Double)) -> WeatherData? {
      print("[READ]: Getting info from the cache")
    let fileName = "\(locationCoordinate.latitude)_\(locationCoordinate.longitude).json"
    guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) else {
      return nil
    }

    do {
      let data = try Data(contentsOf: fileURL)
      return try JSONDecoder().decode(WeatherData.self, from: data)
    } catch {
      print("Error loading cached data:", error)
      return nil
    }
  }

  private static func saveToCache(weatherData: WeatherData, locationCoordinate: (latitude: Double, longitude: Double)) {
      print("[WRITE]: Saving cache")
    let fileName = "\(locationCoordinate.latitude)_\(locationCoordinate.longitude).json"
    guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) else {
      return
    }

    do {
      let data = try JSONEncoder().encode(weatherData)
      try data.write(to: fileURL)
    } catch {
      print("Error saving data to cache:", error)
    }
  }

  // MARK: - Network Fetching

  private static func fetchFromAPI(locationCoordinate: (latitude: Double, longitude: Double), completion: @escaping (Result<WeatherData, Error>) -> Void) {
      print("[FETCH]: Getting info from the API")
    guard let url = apiURLWithParameters(locationCoordinate: locationCoordinate) else {
      completion(.failure(NSError(domain: "URL Error", code: 0, userInfo: nil)))
      return
    }

    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard let data = data, error == nil else {
        completion(.failure(error ?? NSError(domain: "Network Error", code: 0, userInfo: nil)))
        return
      }

      do {
        var weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
        if weatherData.cod != "200" {
          completion(.failure(NSError(domain: "API Error", code: Int(weatherData.cod) ?? 0, userInfo: nil)))
          return
        }
        weatherData.list[0].dt = Int64(Date().timeIntervalSince1970)
        saveToCache(weatherData: weatherData, locationCoordinate: locationCoordinate)
        completion(.success(weatherData))
      } catch {
        completion(.failure(error))
      }
    }
    task.resume()
  }

  private static func apiURLWithParameters(locationCoordinate: (latitude: Double, longitude: Double)) -> URL? {
    let apiKey = Environment.apiKey // Assuming Environment struct stores the API key
    let urlString = "\(apiURL)?lat=\(locationCoordinate.latitude)&lon=\(locationCoordinate.longitude)&appid=\(apiKey)&units=metric&cnt=1"
    return URL(string: urlString)
  }
}
