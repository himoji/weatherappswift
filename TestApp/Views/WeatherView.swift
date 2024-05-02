import SwiftUI


struct WeatherView: View {
    var city: City
    let temperature: Int = 1 // Temperature in Celsius
    @State public var speed = 0.0
    @State private var isEditing = false


    var body: some View {
        let gradientColors = gradientColorsForTemperature(Int(speed))
        
        ScrollView {
            VStack(spacing: 16) {
                MapView(coordinate: city.locationCoordinate)
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("\(city.name), \(city.country)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Divider()
                    
                    HStack {
                        Text("Temperature:")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text("\(Int(speed))°C")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    
                    HStack {
                        Text("Conditions:")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text("Sunny with some wind")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    
                    Divider()
                    
                    Text("About \(city.name)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text(city.description)
                        .font(.body)
                        .foregroundColor(.primary)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .padding()
            }
            VStack {
                    Slider(
                        value: $speed,
                        in: -40...40,
                        onEditingChanged: { editing in
                            isEditing = editing
                        }
                    )
                    Text("\(speed)")
                        .foregroundColor(isEditing ? .red : .blue)
                }
            .padding(.top, 16)
        }
        .navigationTitle(city.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom)
            )
    }
    
    private func gradientColorsForTemperature(_ temperature: Int) -> [Color] {
        if temperature <= 0 {
            // Cold temperature, blue gradient
            return [Color.black.opacity(0.8), Color.blue.opacity(0.8), Color.blue.opacity(1)]
        } else if temperature > 0 && temperature <= 10{
            // Hot temperature, orange gradient
            return [Color.blue.opacity(0.6), Color.blue.opacity(0.4)]
        } else if temperature > 10 && temperature <= 20{
            // Hot temperature, orange gradient
            return [Color.blue.opacity(0.4), Color.mint.opacity(0.6)]
        }
        else if temperature > 20 && temperature < 30 {
            // Hot temperature, orange gradient
            return [Color.mint.opacity(0.6), Color.orange.opacity(0.4)]
        }else {
            // Moderate temperature, green gradient
            return [Color.orange.opacity(0.4), Color.orange.opacity(0.6)]
        }
    }
}
#Preview {
    WeatherView(city: cities[0])
}
