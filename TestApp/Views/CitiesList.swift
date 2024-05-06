import SwiftUI

struct CitiesList: View {
    @State private var isAddCitySheetPresented = false
    @State private var cities: [City] = getCitiesFromUserDocuments()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cities) { city in
                    NavigationLink(destination: WeatherView(city: city)) {
                        CitiesRow(city: city)
                    }
                }
                .onDelete(perform: deleteCity)
            }
            .navigationTitle("Cities")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddCitySheetPresented = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $isAddCitySheetPresented) {
            AddCityView()
        }
        .onDisappear {
            do {
                try saveCitiesToDocuments(cities)
            } catch {
                return
            }
        }
    }
    
    func deleteCity(at offsets: IndexSet) {
        cities.remove(atOffsets: offsets)
        do {
            try saveCitiesToDocuments(cities)
        } catch {
            return
        }
    }
}


#Preview {
    CitiesList()
}
