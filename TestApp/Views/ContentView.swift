import SwiftUI

struct ContentView: View {
    // State variable to track whether to navigate to the WeatherView
    @State private var navigateToWeatherView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Welcome to ProjectPogoda")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Stay Ahead of the Weather")
                    .font(.headline)
                    .foregroundColor(.gray)
                
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
                
                NavigationLink(destination: CitiesList()) {
                    Text("Get Started")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding()
                }
            }
            .navigationBarHidden(true)
        }
    }
}
#Preview {
    ContentView()
}
