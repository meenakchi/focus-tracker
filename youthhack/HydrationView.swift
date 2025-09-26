import SwiftUI

struct HydrationView: View {
    @State private var fillAmount: CGFloat = 0.0
    @State private var isFull = false
    @State private var sway = false
    
    let bottleHeight: CGFloat = 250
    let bottleWidth: CGFloat = 120
    let stamps: [CGFloat] = [0.0, 0.5, 1.0] // 0L, 0.5L, 1L
    
    var body: some View {
        ZStack {
            Color.cyan.opacity(0.2).ignoresSafeArea()
            
            VStack(spacing: 20) { // reduced spacing
                Text("Help Octoo stay hydrated💧")
                    .font(.title2)
                    .bold()
                    .padding(35)
                
                ZStack(alignment: .bottom) {
                    // Bottle outline
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 6)
                        .foregroundColor(.blue)
                        .frame(width: bottleWidth, height: bottleHeight)
                    
                    // Water inside
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue.opacity(0.7))
                        .frame(width: bottleWidth - 10, height: bottleHeight * fillAmount)
                        .animation(.easeInOut(duration: 0.3), value: fillAmount)
                    
                    // Liter stamps inside the bottle
                    VStack {
                        ForEach(stamps.reversed(), id: \.self) { stamp in
                            Spacer()
                            Text("\(stamp == 0 ? "0" : String(format: "%.1f", stamp))L")
                                .font(.caption)
                                .foregroundColor(.black)
                                .bold()
                        }
                        Spacer()
                    }
                    .frame(height: bottleHeight - 10)
                }
                
                Button(action: {
                    if fillAmount < 1.0 {
                        fillAmount += 0.1
                        checkStampAnimation()
                        if fillAmount >= 1.0 {
                            isFull = true
                        }
                    }
                }) {
                    Text(isFull ? "🎉 Octoo is Hydrated!" : "Tap to Drink")
                        .padding()
                        .frame(width: 220)
                        .background(isFull ? Color.green : Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .shadow(radius: 5)
                }
                .disabled(isFull)
                
                if isFull {
                    Text("Yayy!! Octoo is now fully hydrated for the day which keeps his body energised! 🥳\n\nDrink loads of water too and aim for 1.5L a day like Octoo!")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                        .transition(.slide)
                        .animation(.easeInOut, value: isFull)
                }
                
                Spacer()
                
                // Octoo
                Image("octoo")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(sway ? 10 : 0)) // start straight
                    .animation(.easeInOut(duration: 0.2).repeatCount(5, autoreverses: true), value: sway)
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
    
    private func checkStampAnimation() {
        // Octoo sways when reaching each stamp (0.5L, 1L)
        if stamps.contains(where: { abs(fillAmount - $0) < 0.05 }) {
            sway.toggle()
        }
    }
}

#Preview {
    HydrationView()
}
