import SwiftUI

struct WeatherView: View {
    @State public var selectedDate: Date = Date()
    @State private var isDatePickerVisible: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    HStack {

                        Text("Astana")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("🇰🇿")
                            .font(.title)
                            .padding(.trailing, 10)
                    }
                    .padding(.bottom, 5)
                    
                    Text("19 °C")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    HStack {
                        Text("☀️")
                        Text("💨")
                    }
                    .font(.title)
                    .padding(.top, 10)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button(action: {
                        isDatePickerVisible.toggle()
                    }) {
                        Text("Select Date")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 20)
                }
                .padding()
                
                Spacer()
                
                // DatePicker
                if isDatePickerVisible {
                    DatePicker("Select a Date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                }
            }
        }
        .foregroundColor(.white)
        .navigationTitle("Weather Forecast")
    }
}


#Preview{
    WeatherView()
}
