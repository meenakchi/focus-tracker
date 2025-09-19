import SwiftUI
//because i wanna add a storyline
enum AppStage {
    case intro
    case story
    case menu
}

struct IntroView: View {
    @State private var bounce = false
    @State private var showMenu = false
    var onNext: () -> Void
    
    var body: some View {
        ZStack {
            // Background parts
            Rectangle()
                .foregroundColor(Color("wall"))
                .frame(width: 600, height: 350)
                .offset(x: 100, y:-275)
            
            Rectangle()
                .foregroundColor(Color("floor"))
                .frame(width: 600, height: 550)
                .offset(x: 100, y: 175)
            
            Image("door")
                .resizable()
                .frame(width: 150, height: 200)
                .offset(x: -125, y: -200)
            
            Image("curtains")
                .resizable()
                .frame(width: 250, height: 230)
                .offset(x: 100, y:-250)
            
            Image("bed")
                .resizable()
                .frame(width: 150, height: 200)
                .offset(x: 150, y:-100)
            
            Image("plant")
                .resizable()
                .frame(width: 170, height: 210)
                .offset(x: 140, y:320)
            
            Image("table")
                .resizable()
                .frame(width: 240, height: 290)
                .offset(x: -120 ,y: 100)
            
            // Octoo + bubble
            VStack {
                if !showMenu {
                    // Speech bubble above Octoo
                    Text("Click me to start!")
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                        .offset(x: 0, y: 10)
                }
                
                // Octoo button
                Button(action: {
                    withAnimation {
                        onNext() // move to storyView
                    }
                }) {
                    Image("octoo")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .offset(x: 10, y: bounce ? 10:40)
                        .animation(
                            Animation.easeInOut(duration: 0.6)
                                .repeatForever(autoreverses: true),
                            value: bounce
                        )
                }
                .onAppear {
                    bounce = true
                }
            }
            .offset(x: 80, y: 90) // position Octoo + bubble stack
        }
        .padding()
    }
}

#Preview {
    IntroView(onNext: { })
}

