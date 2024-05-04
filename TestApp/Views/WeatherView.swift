import SwiftUI



struct WeatherView: View {
    var city: City
    @State private var temperature: Double = 0.0 // Temperature in Celsius
    
    var body: some View {
        ScrollView {
            MapView(coordinate: city.locationCoordinate)
                .frame(height: 300)
            
            
            CircleImage(image: city.image)
                .offset(y: -130)
                .padding(.bottom, -130)
                
            
            
            WeatherDetailsView(city: city, temperature: 12.0)
                .padding(.top, 80)
                .padding(.leading, 10)
        }
        .navigationTitle(city.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WeatherDetailsView: View {
    var city: City
    var temperature: Float
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // City name
            Text("\(city.name), \(city.country)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Divider()
            
            // Temperature
            HStack {
                Text("Temperature:")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("\(String(format: "%.1f", temperature))°C")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("\(city.apiLink)")
            }
            
            // Conditions
            HStack {
                Text("Conditions:")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("Sunny with some wind")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            
            Divider()
            
            // About city
            Text("About \(city.name)")
                .font(.title2)
                .fontWeight(.bold)
            
            Text(city.description)
                .font(.body)
        }
    }
}

#Preview {
    WeatherView(city: cities[0])
}


