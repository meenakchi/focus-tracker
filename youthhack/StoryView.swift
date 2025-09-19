import SwiftUI

struct StoryLine {
    let text: String
    let imageName: String
}

struct StoryView: View {
    var onNext: () -> Void
    
    // Each line has its own image and text
    let storyLines: [StoryLine] = [
        StoryLine(text: "Octoo was in class about to recieve his exam grades..", imageName: "lineone"),
        StoryLine(text: "'Octoo, You have failed your test' said the teacher. You have lost your focus in class. ", imageName: "linetwo"),
        StoryLine(text: "Then octoo asked a question.. 'How to focus better ?'", imageName: "linethree"),
        StoryLine(text: "Then his teacher said 'eat healthy, sleep on time, meditate, Hydrate your body'", imageName:"linefour"),
        StoryLine(text: "Will you help octoo focus better ? and find out how you can focus too !", imageName: "linefive")
    ]
    
    @State private var currentLine = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            // Display the image for the current line
            Image(storyLines[currentLine].imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .padding(.bottom, 20)
            
            // Story text
            Text(storyLines[currentLine].text)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(12)
                .shadow(radius: 3)
            
            Spacer()
            
            // Next button
            Button(action: {
                if currentLine < storyLines.count - 1 {
                    currentLine += 1
                } else {
                    onNext()
                }
            }) {
                Text(currentLine < storyLines.count - 1 ? "Next" : "Continue")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
        }
        .padding()
    }
}

#Preview {
    StoryView(onNext: { })
}
