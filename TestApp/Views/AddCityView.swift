import SwiftUI
import MapKit

struct AddCityView: View {
    @State private var cityName = ""
    @State private var countryName = ""
    @State private var coordinates = CLLocationCoordinate2D(latitude: 49.8015465, longitude: 73.1)

    var body: some View {
        VStack {
            VStack {
                TextField("Enter city name", text: $cityName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Enter country name", text: $countryName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Button(action: searchCity) {
                Text("Search City")
            }
            .padding()
            
            Button(action: {
                let newCity = City(id: Int.random(in: 1...1000),
                                   name: cityName,
                                   country: countryName,
                                   description: "",
                                   imageName: "",
                                   coordinates: City.Coordinates(latitude: coordinates.latitude, longitude: coordinates.longitude))
                saveCity(city: newCity)
            }) {
                Text("Save City")
            }
            .disabled(cityName.isEmpty || coordinates.latitude == 49.8015465 && coordinates.longitude == 73.1)

            MapView(coordinate: coordinates)
                .ignoresSafeArea()
        }
    }

    func searchCity() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "\(cityName), \(countryName)"
        let search = MKLocalSearch(request: request)

        search.start { response, _ in
            guard let response = response else { return }
            guard let firstItem = response.mapItems.first else { return }

            coordinates = firstItem.placemark.coordinate
        }
    }
    
    func saveCity(city: City) {
        if let encoded = try? JSONEncoder().encode(city) {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent("cityData.json")
            try? encoded.write(to: fileURL)
        }
    }
}

struct CityAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
}

struct AddCityView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityView()
    }
}
