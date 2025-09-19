//
//  MeditationView.swift
//  youthhack
//
//  Created by user on 18/9/25.
//

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
    @State private var thoughts: [NegativeThoughts] = [
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
    
    let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.2).ignoresSafeArea()
            
            Text("Don't let distractions reach Octoo❗️")
                .font(.title)
                .bold()
                .offset(x: -10, y: -300)
            
            // 🐙 Octopus in center
            VStack {
                Spacer()
                Image("octoomeditating")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .offset(x: 0, y: 300)
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
                                    // If dragged far, remove
                                    if abs(value.translation.width) > 150 || abs(value.translation.height) > 150 {
                                        withAnimation {
                                            thoughts.remove(at: index)
                                        }
                                    } else {
                                        // Snap back
                                        withAnimation {
                                            thoughts[index].offset = .zero
                                        }
                                    }
                                }
                            }
                    )
            }
            
            // Add new thoughts button
            VStack {
                Spacer()
                Button("Add Thought") {
                    let newEmoji = ["📱", "🍔", "🎮", "💤", "💻"].randomElement()!
                    thoughts.append(NegativeThoughts(emoji: newEmoji))
                }
                .padding()
                .background(Color.purple.opacity(0.8))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .shadow(radius: 5)
            }
        }
        .onReceive(timer) { _ in
            for index in thoughts.indices {
                // Update falling only if not dragged
                if thoughts[index].offset == .zero {
                    thoughts[index].yPosition += thoughts[index].speed
                    
                    // If it reaches bottom, Octoo "hit" logic (remove it)
                    if thoughts[index].yPosition > UIScreen.main.bounds.height - 150 {
                        withAnimation {
                            thoughts.remove(at: index)
                        }
                        break // prevent index out of range
                    }
                }
            }
        }
    }
}

#Preview {
    MeditationView()
}
