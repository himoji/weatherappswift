import Foundation

// Define Codable structs to represent the JSON structure

struct WeatherData: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [WeatherInfo]
    let city: CityInfo
}

struct WeatherInfo: Codable {
    let dt: TimeInterval // Ignored
    let main: MainInfo
    let weather: [WeatherDetail]
    let wind: WindInfo
    // Fields ignored: sea_level, grnd_level, temp_kf, clouds, visibility, sys, pop, dt_txt
}

struct MainInfo: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int // Ignored
    let humidity: Int
    // Fields ignored: sea_level, grnd_level
}

struct WeatherDetail: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WindInfo: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct CityInfo: Codable {
    // Fields ignored: id, population
    let name: String
    let coord: CoordInfo
    let country: String
    let timezone: Int
    let sunrise: TimeInterval
    let sunset: TimeInterval
}

struct CoordInfo: Codable {
    let lat: Double
    let lon: Double
}

// API Parser function

func parseWeatherData(from data: Data) -> Result<WeatherData, Error> {
    do {
        let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
        // Check if cod is 200
        if weatherData.cod != "200" {
            return .failure(NSError(domain: "API Error", code: Int(weatherData.cod) ?? 0, userInfo: nil))
        }
        return .success(weatherData)
    } catch {
        return .failure(error)
    }
}

// Example usage
/*
let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(locationCoordinate.latitude)&lon=\(locationCoordinate.longitude)&appid=\(Environment.apiKey)&units=metric&cnt=1")!
let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    guard let data = data, error == nil else {
        print("Error:", error ?? "Unknown error")
        return
    }
    
    switch parseWeatherData(from: data) {
    case .success(let weatherData):
        print("Sunrise time:", weatherData.city.sunrise)
        // Access other weather data properties as needed
    case .failure(let error):
        print("Error parsing weather data:", error)
    }
}
task.resume()
*/
