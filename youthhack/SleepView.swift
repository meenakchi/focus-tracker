import SwiftUI

struct SleepView: View {
    @State private var selectedTime: Int? = nil
    @State private var feedback: String? = nil

    let sleepOptions = [8, 10, 12]
    
    var body: some View {
        ZStack{
            Color.pink.opacity(0.2)
                .ignoresSafeArea()
              
            VStack(spacing: 40) {
                Text("Bed time, octoo!🛏️")
                    .font(.title)
                    .fontWeight(.bold)
                    .offset(y: -190)
                
                HStack(spacing: 30) {
                    ForEach(sleepOptions, id: \.self) { time in
                        Button(action: {
                            checkAnswer(time)
                        }) {
                            VStack {
                                Image("clock\(time)")
                                    .resizable()
                                    .frame(width: 110, height: 110)
                                Text("\(time):00")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                .offset(y: -55)
                
                // Reserve space for feedback to prevent shifting
                Group {
                    if let feedback = feedback {
                        Text(feedback)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding()
                            
                    } else {
                        // Invisible placeholder
                        Text("placeholder")
                            .font(.body)
                            .opacity(0)
                            .padding()
                    }
                }
                .frame(minHeight: 60) // keeps layout stable
            }
            
            Image("octoosleeping")
                .resizable()
                .frame(width: 200, height: 190)
                .offset( x: -90, y: 300 )
            
            Text("What time should i sleep to stay focused tommorow ?😴")
                .font(.system(size: 16, weight: .medium))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .frame(width: 260)
                .offset(y: -270)
        }
    }
    
    func checkAnswer(_ time: Int) {
        selectedTime = time
       
        if time == 8 {
            feedback = "🌙 Great job! Sleeping early helps Octoo focus better in class tomorrow."
        } else if time == 10 {
            feedback = "😴 Not bad, but earlier sleep is even better for Octoo's focus."
        } else {
            feedback = "💤 Oh no! Octoo sleeps less and can't focus well tomorrow in class."
        }
    }
}

#Preview {
    SleepView()
}
