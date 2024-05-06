import SwiftUI

struct CitiesList: View {
    @State private var isAddCitySheetPresented = false
    @State private var cities: [City] = load()
    
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
            save() // Save cities data when the view disappears
        }
    }
    
    func deleteCity(at offsets: IndexSet) {
        cities.remove(atOffsets: offsets)
    }
}


#Preview {
    CitiesList()
}
