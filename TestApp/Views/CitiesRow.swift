import SwiftUI

struct CitiesRow: View {
    var city: City

    var body: some View {
        HStack {
            city.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(city.name)
            
            Spacer()

        }
    }
}

#Preview {
    CitiesRow(city: cities[0])
}
