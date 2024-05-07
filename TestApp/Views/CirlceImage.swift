import SwiftUI

struct CircleImage: View {
  let image: Image? // Allow optional image (can be nil)

  var body: some View {
    if let image = image {
      // Display existing image
      image
        .resizable()
        .scaledToFit()
        .clipShape(Circle())
        .overlay {
          Circle().stroke(Color.white, lineWidth: 4)
        }
        .frame(width: 320, height: 320)
        .shadow(radius: 7)
    } else {
      // Show nothing or alternative view (optional)
      EmptyView() // Or your desired view for no image
    }
  }
}

// Preview (optional for testing in Xcode)
#Preview() {
  CircleImage(image: Image("astana"))
}
