import SwiftUI

struct WeatherDetailsView: View {
    let city: City
    @StateObject var weatherViewModel: WeatherViewModel
    
    init(city: City) {
        self.city = city
        self._weatherViewModel = StateObject(wrappedValue: WeatherViewModel(city: city))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("\(city.name), \(city.country)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Divider()
                
                if let weatherData = weatherViewModel.weatherData {
                    VStack(alignment: .center, spacing: 20) {
                        
                        // Weather temperature information
                        HStack {
                            VStack(alignment: .center) {
                                Text("Min Temp").padding()
                                Text("\(String(format: "%.1f",weatherData.list[0].main.temp_min))°C").font(.title3)
                            }
                            
                            VStack(alignment: .center) {
                                Text("Current temp").padding()
                                Text("\(String(format: "%.1f",weatherData.list[0].main.temp))°C").font(.title3)
                            }
                            
                            VStack(alignment: .center) {
                                Text("Max Temp").padding()
                                Text("\(String(format: "%.1f",weatherData.list[0].main.temp_max))°C").font(.title3)
                            }
                        }
                        
                        
                        VStack(alignment: .center) {
                            // Weather description
                            Text("Weather")
                                .font(.headline)
                                .fontWeight(.regular)
                                .padding()
                            Text("\(weatherData.list[0].weather[0].description.capitalized)")
                                .font(.title3)
                                .foregroundColor(.primary)
                        }
                        
                        
                        
                        // Other weather information
                        HStack {
                            VStack(alignment: .center) {
                                Text("Humidity").padding()
                                Text("\(weatherData.list[0].main.humidity)%").font(.title3)
                            }
                            
                            VStack(alignment: .center) {
                                Text("Pressure").padding()
                                Text("\(weatherData.list[0].main.pressure) gPa").font(.title3)
                            }
                            
                            VStack(alignment: .center) {
                                Text("Feels like").padding()
                                Text("\(String(format: "%.1f",weatherData.list[0].main.feels_like))°C").font(.title3)
                            }
                        }

                        // Time information
                        HStack {
                            VStack(alignment: .center) {
                                Text("Sunrise").padding()
                                Text("\(formattedDate(date: Date(timeIntervalSince1970: TimeInterval(weatherData.city.sunrise)), timezoneOffset: weatherData.city.timezone))").font(.title3)
                            }
                            
                            VStack(alignment: .center) {
                                Text("Current time").padding()
                                Text("\(formattedDate(date: Date(), timezoneOffset: weatherData.city.timezone))").font(.title3)
                            }
                            
                            VStack(alignment: .center) {
                                Text("Sunset").padding()
                                Text("\(formattedDate(date: Date(timeIntervalSince1970: TimeInterval(weatherData.city.sunset)), timezoneOffset: weatherData.city.timezone))").font(.title3)
                            }
                        }
                    }
                    
                } else if let error = weatherViewModel.error {
                    Text("Error: \(error.localizedDescription)")
                        .foregroundColor(.red)
                } else {
                    ProgressView()
                }
                
                
                
                if !city.description.isEmpty {
                  Divider()
                    
                  Text("About \(city.name)")
                    .font(.title)
                    .fontWeight(.bold)
                  Text(city.description)
                    .font(.body)
                }

            }.padding()
        }
        .navigationBarTitle(Text("Weather Details"), displayMode: .inline)
        .onAppear {
            fetchCity()
        }
    }
    
    func fetchCity() {
        // Call fetchWeatherData only if weatherData is nil
        if weatherViewModel.weatherData == nil {
            weatherViewModel.fetchWeatherData()
        }
    }
    
    private func formattedDate(date: Date, timezoneOffset: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: timezoneOffset) // Set timezone to UTC
        
        return formatter.string(from: date)
    }
}

struct WeatherInfoView: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
    }
}

class WeatherViewModel: ObservableObject {
    let city: City
    @Published var weatherData: WeatherData?
    @Published var error: Error?
    
    init(city: City) {
        self.city = city
    }
    
    func fetchWeatherData() {
        WeatherFetcher.getInfo(locationCoordinate: (latitude: Double(city.locationCoordinate.latitude), longitude: Double(city.locationCoordinate.longitude))) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherData):
                    self.weatherData = weatherData
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
}

#Preview {
    WeatherDetailsView(city: cities[0])
}
