import SwiftUI

struct CitiesList: View {
    var body: some View {
        NavigationSplitView {
            List(cities) { city in

                NavigationLink {
                    WeatherView(city: city)
                } label: {
                    CitiesRow(city: city)
                }

            }
            .navigationTitle("Cities")

        } detail: {
            Text("Select a city")
        }

    }

}

#Preview {
    CitiesList()
}