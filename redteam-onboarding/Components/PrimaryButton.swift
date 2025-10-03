//
//  PrimaryButton.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 10/1/25.
//

import SwiftUI

/// Primary action button with consistent styling
struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var isSecondary: Bool = false
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(minWidth: 200)
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                .background(isSecondary ? Color.secondary.opacity(0.2) : Color.accentColor)
                .foregroundStyle(isSecondary ? Color.primary : Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
        .hoverEffect()
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    VStack(spacing: 20) {
        PrimaryButton(title: "Let's Begin", action: {})
        PrimaryButton(title: "Skip for now", action: {}, isSecondary: true)
    }
    .padding()
}

