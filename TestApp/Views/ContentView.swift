import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
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
                
                NavigationLink(destination: CitiesList(), label: {
                    Text("Get Started")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding()
                })
            }
            
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
            
            
        }
    }
}
#Preview {
    ContentView()
}
