import SwiftUI

struct CitiesList: View {
    var body: some View {
        NavigationStack {
            List(cities) { city in

                NavigationLink {
                    WeatherView(city: city)
                } label: {
                    CitiesRow(city: city)
                }

            }
            .navigationTitle("Cities")

        }
    }

}

#Preview {
    CitiesList()
}
