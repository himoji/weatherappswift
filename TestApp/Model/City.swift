import Foundation
import SwiftUI
import CoreLocation

struct City: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var country: String
    var description: String

    private var imageName: String

    var image: Image {
        Image(imageName)
    }


    private var coordinates: Coordinates

    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }


    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}