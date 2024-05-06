import SwiftUI
import MapKit

struct AddCityView: View {
    @State private var cityName = ""
    @State private var countryName = ""
    @State private var coordinates = CLLocationCoordinate2D(latitude: 49.8015465, longitude: 73.1)
    @State private var city: City?
    
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
            
            Button(action: {
                searchCity()
            }) {
                Text("Search City")
            }
            .padding()
            
            Button(action: {
                if let city = city {
                    saveCity(city: city)
                }
            }) {
                Text("Save City")
            }
            .disabled(cityName.isEmpty || coordinates.latitude == 49.8015465 && coordinates.longitude == 73.1)
            .padding()
            
            MapView(coordinate: coordinates)
                .ignoresSafeArea()
        }
    }
    
    func searchCity() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "\(cityName), \(countryName)"
        let search = MKLocalSearch(request: request)
        
        search.start { response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error searching for city: \(error.localizedDescription)")
                    return
                }
                
                guard let response = response, let firstItem = response.mapItems.first else {
                    print("No results found")
                    return
                }
                
                let coordinates = firstItem.placemark.coordinate
                let name = firstItem.placemark.locality ?? ""
                let country = firstItem.placemark.country ?? ""
                let id = Int.random(in: 1...1000)
                
                let newCity = City(id: id, name: name, country: country, description: "", imageName: "", coordinates: City.Coordinates(latitude: coordinates.latitude, longitude: coordinates.longitude))
                self.city = newCity
                self.coordinates = coordinates
            }
        }
    }
    
    func saveCity(city: City) {
        DispatchQueue.global(qos: .background).async {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent("cityData.json")
            
            var cities: [City]
            
            do {
                let jsonData = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                cities = try decoder.decode([City].self, from: jsonData)
            } catch {
                print("Error loading existing city data: \(error)")
                cities = []
            }
            
            cities.append(city)
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            do {
                let encoded = try encoder.encode(cities)
                try encoded.write(to: fileURL)
                print("City data appended and saved to: \(fileURL)")
            } catch {
                print("Error saving city data: \(error)")
            }
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
