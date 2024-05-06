import SwiftUI

@main
struct ProjectPogoda: App {
    init() {
            copyJSONFileToDocumentsDirectoryIfNeeded()
        }
    var body: some Scene {
        WindowGroup {
            CitiesList()
        }
    }
}
