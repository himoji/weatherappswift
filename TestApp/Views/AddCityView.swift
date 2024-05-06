import SwiftUI
import MapKit

struct AddCityView: View {
    @State private var cityName = ""
    @State private var countryName = ""
    @State private var coordinates = CLLocationCoordinate2D(latitude: 49.8015465, longitude: 73.1)
    @State private var city: City = City(id: 0, name: "", country: "", description: "", imageName: "", coordinates: City.Coordinates(latitude: 49.8015465, longitude: 73.1))
    @State private var saveResult: SaveCityResult? = nil
    
    func saveCity(_ city: City) {
        saveResult = saveCity(city)
    }
    
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
            
            Button("Save City") {
                saveCity(city)
            }
            .disabled(cityName.isEmpty || coordinates.latitude == 49.8015465 && coordinates.longitude == 73.1) // Disable button if duplicate exists
            .overlay(
                saveResult.map { result in
                    Text(message(for: result))
                        .foregroundColor(color(for: result))
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(color(for: result).opacity(0.3)))
                }
            )
            
            MapView(coordinate: coordinates)
                .ignoresSafeArea()
        }
    }
    
    private func message(for result: SaveCityResult) -> String {
        switch result {
        case .success:
            return "City saved successfully!"
        case .duplicateCity:
            return "A city with the same location already exists."
        case .saveError(let error):
            return "Error saving city: \(error.localizedDescription)"
        }
    }
    
    private func color(for result: SaveCityResult) -> Color {
        switch result {
        case .success:
            return .green
        case .duplicateCity:
            return .yellow
        case .saveError:
            return .red
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
    
    func saveCity(_ city: City) -> SaveCityResult {
        var cities: [City] = getCitiesFromBundle()
        
        if hasIdenticalCoordinates(cities: cities, city1: city) {
            return .duplicateCity
        }
        
        cities.append(city)
            
        do {
            print(cities)
            try saveCitiesToDocuments(cities)
            return .success
        } catch {
            print("\(error)")
            return .saveError(error)
        }
    }
}

enum SaveCityResult {
  case success
  case duplicateCity
  case saveError(Error)
}

struct AddCityView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityView()
    }
}
