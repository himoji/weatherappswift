import SwiftUI


struct WeatherView: View {
    var city: City
    @State private var temperature: Double = 0.0 // Temperature in Celsius
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Map view
                MapView(coordinate: city.locationCoordinate)
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                // Weather details
                WeatherDetailsView(city: city, temperature: $temperature)
                    .padding(.all)
                
                ImageCarousel(images: ["astana","astana", "astana"])
                    .padding(.bottom, 12.0)
                   
            }
        }
        .padding(.top, 10.0)
        .navigationTitle(city.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(
            LinearGradient(colors: [.init(red: 48/255, green: 64/255, blue: 96/255),
                                     .init(red: 39/255, green: 40/255, blue: 62/255)],
                           startPoint: .bottom, endPoint: .top)
        )
    }
}

struct WeatherDetailsView: View {
    var city: City
    @Binding var temperature: Double
    
    var body: some View {
        ZStack {
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
            .padding()
            .navigationTitle(city.name)
            .navigationBarTitleDisplayMode(.inline)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 8))
        }
        
    }
}
   
#Preview {
    WeatherView(city: cities[0])
}


