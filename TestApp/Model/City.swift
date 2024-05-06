import Foundation
import SwiftUI
import CoreLocation

public struct City: Hashable, Codable, Identifiable {
    public var id: Int
    var name: String
    var country: String
    var description: String
    var imageName: String
    public var coordinates: Coordinates
    
    init(id: Int, name: String, country: String, description: String, imageName: String, coordinates: Coordinates) {
        self.id = id
        self.name = name
        self.country = country
        self.description = description
        self.imageName = imageName
        self.coordinates = coordinates
    }
    
    var image: Image {
        Image(imageName)
    }
    
    public var apiLink: String {
        "https://api.openweathermap.org/data/2.5/forecast?lat=\(locationCoordinate.latitude)&lon=\(locationCoordinate.longitude)&appid=\(Environment.apiKey)&units=metric&cnt=1"
    }

    public var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }

    public struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
