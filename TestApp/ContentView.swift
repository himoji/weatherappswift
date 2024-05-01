//
//  ContentView.swift
//  TestApp
//
//  Created by User on 26.10.2023.
//

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
                
                Button(action: {
                    // Set the state variable to true to navigate to WeatherView
                    navigateToWeatherView = true
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                
                // Navigation to WeatherView using fullScreenCover
                .fullScreenCover(isPresented: $navigateToWeatherView, content: WeatherView.init)
            }
            .padding()
            .navigationBarHidden(true) // Hide navigation bar in the main page
        }
    }
}

#Preview {
    ContentView()
}
