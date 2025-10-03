//
//  StepProgressDots.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 10/1/25.
//

import SwiftUI

/// Progress indicator dots for onboarding steps
struct StepProgressDots: View {
    let currentStep: OnboardingStep
    let totalSteps: Int = OnboardingStep.allCases.count
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalSteps, id: \.self) { index in
                Circle()
                    .fill(index == currentStep.rawValue ? Color.accentColor : Color.secondary.opacity(0.3))
                    .frame(width: 8, height: 8)
                    .animation(.easeInOut(duration: 0.3), value: currentStep)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Step \(currentStep.rawValue + 1) of \(totalSteps)")
    }
}

#Preview {
    VStack(spacing: 30) {
        StepProgressDots(currentStep: .welcome)
        StepProgressDots(currentStep: .scanTutorial)
        StepProgressDots(currentStep: .finish)
    }
    .padding()
}

