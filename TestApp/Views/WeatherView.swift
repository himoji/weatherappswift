import SwiftUI

struct WeatherView: View {
    var city: city

    var body: some View {

        ScrollView {
            MapView(coordinate: city.locationCoordinate)
                .frame(height: 300)

            CircleImage(image: city.image)
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                Text(city.name)
                    .font(.title)

                Divider()

                Text("About \(city.name)")

                    .font(.title2)

                Text(city.description)

            }

            .padding()

        }

        .navigationTitle(city.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    WeatherView(city: cities[0])
}