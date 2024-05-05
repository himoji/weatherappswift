import SwiftUI

struct CircleImage: View {
    var image: Image


    var body: some View {
        image
            .resizable() // Make the image resizable
            .scaledToFit() // Maintain aspect ratio
            .clipShape(Circle())
            .overlay {
                Circle().stroke(Color.white, lineWidth: 4)
            }
            .frame(width: 320, height: 320)
            .shadow(radius: 7)
    }
}


#Preview() {
    CircleImage(image: Image("astana"))
}
