//
//  HydrationView.swift
//  youthhack
//
//  Created by user on 18/9/25.
//

import SwiftUI

struct HydrationView: View {
    @State private var fillAmount: CGFloat = 0.0
       @State private var isFull = false
       
       var body: some View {
           ZStack {
               Color.cyan.opacity(0.2).ignoresSafeArea()
               
               VStack(spacing: 40) {
                   Text("Help Octoo stay hydrated💧")
                       .font(.title2)
                       .bold()
                   
                   ZStack(alignment: .bottom) {
                       // Bottle outline
                       RoundedRectangle(cornerRadius: 25)
                           .stroke(lineWidth: 6)
                           .foregroundColor(.blue)
                           .frame(width: 120, height: 250)
                       
                       // Water inside
                       RoundedRectangle(cornerRadius: 20)
                           .fill(Color.blue.opacity(0.7))
                           .frame(width: 110, height: 240 * fillAmount)
                           .animation(.easeInOut(duration: 0.3), value: fillAmount)
                   }
                   .padding(.top, 20)
                   
                   Button(action: {
                       if fillAmount < 1.0 {
                           fillAmount += 0.1
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
                   .disabled(isFull) // disable once bottle is full
                   
                   Spacer()
                   
                   // Octoo reacts
                   Image(isFull ? "octoohydrated" : "octoo")
                       .resizable()
                       .frame(width: 200, height: 200)
                       .overlay(
                           Image(isFull ? "reminder" : "")
                            .resizable()
                           .frame(width: 150, height: 100)
                           .offset(x: -120 ,y: -110)
                               
                       )
                   
                   Spacer()
               }
           }
       }
}

#Preview {
    HydrationView()
}
