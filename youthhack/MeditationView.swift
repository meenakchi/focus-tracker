import SwiftUI

struct NegativeThoughts: Identifiable {
    let id = UUID()
    let emoji: String
    var xPosition: CGFloat = CGFloat.random(in: 60...320)
    var yPosition: CGFloat = CGFloat.random(in: -100...0)
    var speed: CGFloat = CGFloat.random(in: 1...3)
    var offset: CGSize = .zero
}

struct MeditationView: View {
    @State private var thoughts: [NegativeThoughts] = MeditationView.generateThoughts()
    @State private var gameMessage: String? = nil
    @State private var gameOver: Bool = false
    
    let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
    
    static func generateThoughts() -> [NegativeThoughts] {
        return [
            NegativeThoughts(emoji: "📱"),
            NegativeThoughts(emoji: "🍔"),
            NegativeThoughts(emoji: "🎮"),
            NegativeThoughts(emoji: "💤"),
            NegativeThoughts(emoji: "⚽️"),
            NegativeThoughts(emoji: "📱"),
            NegativeThoughts(emoji: "🍔"),
            NegativeThoughts(emoji: "🎮"),
            NegativeThoughts(emoji: "💤"),
            NegativeThoughts(emoji: "⚽️")
        ]
    }
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.2).ignoresSafeArea()
            
            Text("Don't let distractions reach Octoo❗️")
                .font(.title2)
                .bold()
                .offset(y: -300)
            
            // 🐙 Octopus
            VStack {
                Spacer()
                Image("octoomeditating")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .offset(y: 300)
                Spacer()
            }
            
            // Falling & draggable thoughts
            ForEach(thoughts) { thought in
                Text(thought.emoji)
                    .font(.system(size: 50))
                    .frame(width: 80, height: 80)
                    .background(Color.white.opacity(0.8))
                    .clipShape(Circle())
                    .shadow(radius: 5)
                    .position(x: thought.xPosition + thought.offset.width,
                              y: thought.yPosition + thought.offset.height)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if let index = thoughts.firstIndex(where: { $0.id == thought.id }) {
                                    thoughts[index].offset = value.translation
                                }
                            }
                            .onEnded { value in
                                if let index = thoughts.firstIndex(where: { $0.id == thought.id }) {
                                    if abs(value.translation.width) > 150 || abs(value.translation.height) > 150 {
                                        withAnimation {
                                            thoughts.remove(at: index)
                                        }
                                        checkWinCondition()
                                    } else {
                                        withAnimation {
                                            thoughts[index].offset = .zero
                                        }
                                    }
                                }
                            }
                    )
            }
            
            // Endgame overlay
            if let msg = gameMessage {
                VStack {
                    Text(msg)
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding()
                    
                    Button("Restart") {
                        restartGame()
                    }
                    .padding()
                    .background(Color.purple.opacity(0.8))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
                .transition(.scale)
            }
        }
        .onReceive(timer) { _ in
            guard !gameOver else { return }
            for index in thoughts.indices {
                if thoughts[index].offset == .zero {
                    thoughts[index].yPosition += thoughts[index].speed
                    
                    // Check if it touches Octoo (near bottom)
                    if thoughts[index].yPosition > UIScreen.main.bounds.height - 150 {
                        endGame(win: false)
                        break
                    }
                }
            }
        }
    }
    
    // MARK: - Game Logic
    
    private func checkWinCondition() {
        if thoughts.isEmpty {
            endGame(win: true)
        }
    }
    
    private func endGame(win: Bool) {
        gameOver = true
        if win {
            gameMessage = "🎉 YAY! Octoo has finished meditating and he feels much calmer and focused! Do meditate to clear your negative thoughts before doing anything important as it clears your mind and helps you focus!"
        } else {
            gameMessage = "😢 Oh no! Octoo got distracted. Try helping him clear his mind before studying again!"
        }
    }
    
    private func restartGame() {
        thoughts = MeditationView.generateThoughts()
        gameOver = false
        gameMessage = nil
    }
}

#Preview {
    MeditationView()
}
