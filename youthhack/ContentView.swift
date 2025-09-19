//
//  ContentView.swift
//  youthhack
//
//  Created by user on 17/9/25.
//

import SwiftUI

struct ContentView: View {
    @State private var stage: AppStage = .intro
        
        var body: some View {
            ZStack {
                switch stage {
                case .intro:
                    IntroView(onNext: { stage = .story })
                case .story:
                    StoryView(onNext: { stage = .menu })
                case .menu:
                    MenuView()
                }
            }
        }
}

#Preview {
    ContentView()
}
