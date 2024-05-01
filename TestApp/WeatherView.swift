import SwiftUI

struct WeatherView: View {
    @State private var selectedDate: Date = Date()
    @State private var isDatePickerVisible: Bool = false
    
    var dateRange: ClosedRange<Date> {
        let minDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        let maxDate = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
        return minDate...maxDate
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    HStack {
                        Spacer()
                        Text("Astana")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
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
                }
                .padding(.top, 20)
                .padding(.horizontal)
                
                Spacer(minLength: 0)
                
                // DatePicker
                if isDatePickerVisible {
                    VStack{
                        DatePicker("Select Date", selection: $selectedDate, in: dateRange, displayedComponents: .date)
                            .labelsHidden()
                            .datePickerStyle(.graphical)
                            .padding(.horizontal) // Add horizontal padding
                            .padding(.bottom, 20)
                        .frame(maxHeight: 350)
                    
                    // Print selected date in console
                    Button(action: {
                        print("Selected Date:", selectedDate)

                    }) {
                        Text("Print Selected Date")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }}
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
