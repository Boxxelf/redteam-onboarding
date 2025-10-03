//
//  WelcomeStepView.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 10/1/25.
//

import SwiftUI

/// First step: Welcome message
struct WelcomeStepView: View {
    let onNext: () -> Void
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            VStack(spacing: 16) {
                Text("Every object has a hidden story.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                CaptionLabel(text: "Let's begin to see differently.")
                    .font(.title3)
            }
            .padding(.horizontal, 60)
            
            Spacer()
            
            PrimaryButton(title: "Let's Begin", action: onNext)
                .padding(.bottom, 60)
        }
    }
}

#Preview {
    WelcomeStepView(onNext: {})
}

