import SwiftUI



struct WeatherView: View {
    var city: City
    @State private var temperature: Double = 0.0 // Temperature in Celsius
    
    var body: some View {
        ScrollView {
            MapView(coordinate: city.locationCoordinate)
                .frame(height: 300)
                
            
            
            CircleImage(image: city.image)
                .offset(y: -180)
                .padding(.bottom, -220)
                
            WeatherDetailsView(city: city)
                
        }
        .navigationTitle(city.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    WeatherView(city: cities[2])
}


