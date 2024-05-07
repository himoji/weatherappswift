import Foundation

// Define Codable structs to represent the JSON structure

struct WeatherData: Codable {
    var cod: String
    var message: Double
    var cnt: Int
    var list: [WeatherInfo]
    var city: CityInfo
}

struct WeatherInfo: Codable {
    var dt: Int64
    var main: MainInfo
    var weather: [WeatherDetail]
    var wind: WindInfo
    // Fields ignored: sea_level, grnd_level, temp_kf, clouds, visibility, sys, pop, dt_txt
}

struct MainInfo: Codable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity: Int
}

struct WeatherDetail: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct WindInfo: Codable {
    var speed: Double
    var deg: Int
    var gust: Double
}

struct CityInfo: Codable {
    // Fields ignored: id, population
    var name: String
    var coord: CoordInfo
    var country: String
    var timezone: Int
    var sunrise: Int64
    var sunset: Int64
}

struct CoordInfo: Codable {
    var lat: Double
    var lon: Double
}
