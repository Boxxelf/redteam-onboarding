//
//  FinishStepView.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 10/1/25.
//

import SwiftUI

/// Final step: Completion message
struct FinishStepView: View {
    let onComplete: () -> Void
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            VStack(spacing: 24) {
                // Success icon
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 100))
                    .foregroundStyle(.green)
                
                VStack(spacing: 16) {
                    Text("You're ready.")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    CaptionLabel(text: "Begin your journey through hidden histories.")
                        .font(.title3)
                }
                .padding(.horizontal, 60)
            }
            
            Spacer()
            
            PrimaryButton(title: "Start Exploring", action: onComplete)
                .padding(.bottom, 60)
        }
    }
}

#Preview {
    FinishStepView(onComplete: {})
}

