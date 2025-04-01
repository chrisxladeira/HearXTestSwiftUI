//
//  SplashViewController.swift
//  HearTestV2
//
//  Created by Christopher  Ladeira  on 2025/03/30.
//

import SwiftUI

struct SplashScreenView: View {
    
    
    @State private var isActive = false
    @State private var opacity = 0.0
    
    var body: some View {
        ZStack {
            Color("background-grey")
                .edgesIgnoringSafeArea(.all)
            
            Image(.hearxLogo)
                .opacity(opacity)
        }
        .onAppear {
            withAnimation(.easeIn(duration: 0.5)) {
                opacity = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Delay
                withAnimation {
                    isActive = true
                }
            }
        }
        .transition(.opacity)
        .overlay(
            isActive ? HomeView().transition(.opacity) : nil
        )
    }
}



#Preview {
    SplashScreenView()
}
