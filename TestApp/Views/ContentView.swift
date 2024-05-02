import SwiftUI

struct ContentView: View {
    // State variable to track whether to navigate to the WeatherView
    @State private var navigateToWeatherView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to WeatherWise")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Stay Ahead of the Weather")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Image(systemName: "cloud.sun.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding()
                
                Text("Accurate Weather Forecasts")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                Text("Get up-to-date weather forecasts for your current location or any location worldwide.")
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                NavigationLink("Get started", value: Color.mint)
                .padding()
                
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
