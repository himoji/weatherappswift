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
                    VStack(alignment: .leading, spacing: 12) {
                        WeatherInfoView(title: "Temperature", value: "\(String(format: "%.1f", weatherData.list[0].main.temp))°C")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        WeatherInfoView(title: "Conditions", value: "\(weatherData.list[0].weather[0].description.capitalized)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        WeatherInfoView(title: "Sunrise", value: formattedDate(date: Date(timeIntervalSince1970: TimeInterval(weatherData.city.sunrise)), timezoneOffset: weatherData.city.timezone))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        WeatherInfoView(title: "Sunset", value: formattedDate(date: Date(timeIntervalSince1970: TimeInterval(weatherData.city.sunset)), timezoneOffset: weatherData.city.timezone))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        WeatherInfoView(title: "Local time", value: formattedDate(date: Date(), timezoneOffset: weatherData.city.timezone))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                } else if let error = weatherViewModel.error {
                    Text("Error: \(error.localizedDescription)")
                        .foregroundColor(.red)
                } else {
                    ProgressView()
                }
                
                Divider()
                
                Text("About \(city.name)")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(city.description)
                    .font(.body)
            }
            .padding()
        }
        .navigationBarTitle(Text("Weather Details"), displayMode: .inline)
        .onAppear {
            fetchCity()
        }
    }
    
    func fetchCity() {
        weatherViewModel.fetchWeatherData()
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
        fetchWeatherData()
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
