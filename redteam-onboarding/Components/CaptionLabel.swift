//
//  CaptionLabel.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 10/1/25.
//

import SwiftUI

/// Styled caption text for hints and descriptions
struct CaptionLabel: View {
    let text: String
    var color: Color = .secondary
    
    var body: some View {
        Text(text)
            .font(.callout)
            .foregroundStyle(color)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    VStack(spacing: 20) {
        CaptionLabel(text: "This is a helpful caption")
        CaptionLabel(text: "You can add more context here", color: .primary)
    }
    .padding()
}

