//
//  MenuView.swift
//  youthhack
//
//  Created by user on 17/9/25.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack {
            ZStack{
                Image("roombg")
                    .resizable()
                    .frame(width: 390, height: 900)
                    .opacity(0.2)
                    
                Image("octoo")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .offset(x: -90, y:350)
                    .rotationEffect(.degrees(8))
                
            VStack(spacing: 25) {
                    Text("How to focus better 🤔?")
                        .bold()
                        .font(.title)
                        .offset(x: -20, y: -40)
                        
                    HStack{
                        NavigationLink(destination: MeditationView()){
                            Label("Meditate" , systemImage: "figure.mind.and.body")
                                .padding()
                                .frame(width: 150 ,height: 150)
                                .background(Color.meditate)
                                .cornerRadius(12)
                                .foregroundColor(.white)
                                .bold()

                        }
                        .padding(20)
                        
                        NavigationLink(destination: EathealthyView()){
                            Label("Eat healthy" , systemImage: "carrot.fill")
                                .padding()
                                .frame(width: 150 ,height: 150)
                                .background(Color.eathealthy)
                                .cornerRadius(12)
                                .foregroundColor(.white)
                                .bold()
                        }
                        .padding(20)
                    }
                    HStack{
                        NavigationLink(destination: HydrationView()){
                            Label("Drink water" , systemImage: "waterbottle.fill")
                                .padding()
                                .frame(width: 150 ,height: 150)
                                .background(Color.water)
                                .cornerRadius(12)
                                .foregroundColor(.white)
                                .bold()
                        }
                        .padding(20)
                        NavigationLink(destination: SleepView()){
                            Label("Sleep on time " , systemImage: "bed.double")
                                .padding()
                                .frame(width: 150 ,height: 150)
                                .background(Color.sleep)
                                .cornerRadius(12)
                                .foregroundColor(.white)
                                .bold()

                        }
                        .padding(20)
                    }
                   
                
                    
                }
            }
        }
            
    }
}

#Preview {
    MenuView()
}
