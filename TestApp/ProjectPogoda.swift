import SwiftUI

@main
struct ProjectPogoda: App {
  var body: some Scene {
    WindowGroup {
      CitiesList()
    }
  }

  // Call copy function during app launch (runs only once)
  static func onLaunch() {
    do {
        try copyCityDataToDocuments()
    } catch {
      print("Error copying city data: \(error)")
    }
  }
}
