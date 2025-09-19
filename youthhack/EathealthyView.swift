//
//  EathealthyView.swift
//  youthhack
//
//  Created by user on 18/9/25.
//

import SwiftUI

struct EathealthyView: View {
    var body: some View {
        ZStack{
            Color.green.opacity(0.2).ignoresSafeArea()
            Image("plate")
                .resizable()
                .frame(width: 400, height: 400)
            Image("veggies")
                .resizable()
                .frame(width: 100, height: 100)
                .offset(x: 120, y: 300)
            Image("fruit")
                .resizable()
                .frame(width: 70, height: 70)
                .offset(x: -5, y: 300)
            Image("pizza")
                .resizable()
                .frame(width: 70, height: 100)
                .offset(x: -120, y: 300)
            Image("fish")
                .resizable()
                .frame(width: 150, height: 70)
                .offset(x: -120, y: -300)
           
        }
        
    }
}

#Preview {
    EathealthyView()
}
