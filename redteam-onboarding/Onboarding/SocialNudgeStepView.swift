//
//  SocialNudgeStepView.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 10/1/25.
//

import SwiftUI

/// Sixth step: Social invitation (skippable)
struct SocialNudgeStepView: View {
    let onAccept: () -> Void
    let onSkip: () -> Void
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            VStack(spacing: 24) {
                // Icon
                Image(systemName: "person.2.circle.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(Color.accentColor)
                
                // Message
                VStack(spacing: 16) {
                    Text("Invite a friend later")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Co-scan to unlock rarer stories.")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 60)
            }
            
            Spacer()
            
            // Action buttons
            VStack(spacing: 16) {
                PrimaryButton(title: "Sounds good", action: onAccept)
                
                Button(action: onSkip) {
                    Text("Skip for now")
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
            }
            .padding(.bottom, 60)
        }
    }
}

#Preview {
    SocialNudgeStepView(onAccept: {}, onSkip: {})
}

