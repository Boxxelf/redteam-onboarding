//
//  NarrativeStepView.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 10/1/25.
//

import SwiftUI
import RealityKit

/// Fourth step: Display artifact card with narrative
struct NarrativeStepView: View {
    let artifact: Artifact
    let onAddToCabinet: () -> Void
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Artifact card
            VStack(spacing: 24) {
                // 3D Tea Bowl model
                Model3D(named: "tang_glaze") { model in
                    model
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                } placeholder: {
                    ProgressView()
                        .scaleEffect(1.5)
                }
                .padding(.bottom, 10)
                
                // Title
                Text(artifact.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                // Metadata
                HStack(spacing: 20) {
                    Label(artifact.region, systemImage: "location.fill")
                    Label(artifact.era, systemImage: "calendar")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                // Description
                Text(artifact.shortDescription)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .padding(.horizontal, 20)
            }
            .padding(40)
            .background(Color.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 60)
            
            Spacer()
            
            PrimaryButton(title: "Add to Cabinet", action: onAddToCabinet)
                .padding(.bottom, 60)
        }
    }
}

#Preview {
    NarrativeStepView(artifact: .sample, onAddToCabinet: {})
}

