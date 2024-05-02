import SwiftUI

struct ImageCarousel: View {
    var images: Array<String>
    var body: some View {
        AutoScroller(imageNames: images)
    }
}
struct AutoScroller: View {
    var imageNames: [String]
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    @State private var selectedImageIndex: Int = 0

    var body: some View {
        ZStack {
           
            Color.secondary
                .ignoresSafeArea()

         
            TabView(selection: $selectedImageIndex) {
              
                ForEach(0..<imageNames.count, id: \.self) { index in
                    ZStack(alignment: .topLeading) {
                   
                        Image("\(imageNames[index])")
                            .resizable()
                            .tag(index)
                    }
                    .background(.thinMaterial)
                }
            }
            
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea()

            HStack {
                ForEach(0..<imageNames.count, id: \.self) { index in
               
                    Capsule()
                        .fill(Color.white.opacity(selectedImageIndex == index ? 1 : 0.33))
                        .frame(width: 35, height: 8)
                        .onTapGesture {
                           
                            selectedImageIndex = index
                        }
                }
                .offset(y: 130)
            }
        }.frame(width:300, height: 200)
        .onReceive(timer) { _ in
            
            withAnimation(.default) {
                selectedImageIndex = (selectedImageIndex + 1) % imageNames.count
            }
        }
    }
}

#Preview() {
    ImageCarousel(images: ["astana","astana","astana","astana"])
}
