//
//  CabinetIntroStepView.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 10/1/25.
//

import SwiftUI
import RealityKit

/// Fifth step: Cabinet preview with interactive controls
struct CabinetIntroStepView: View {
    let artifact: Artifact
    let onContinue: () -> Void
    
    @State private var rotation: Double = 0
    @State private var scale: Double = 1.0
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Cabinet/Shelf mock
            VStack(spacing: 30) {
                // Shelf preview
                ZStack {
                    // Shelf background
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.secondary.opacity(0.15))
                        .frame(height: 250)
                    
                    // Artifact preview with transformations
                    Model3D(named: "tang_glaze") { model in
                        model
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                    } placeholder: {
                        ProgressView()
                    }
                    .rotation3DEffect(
                        Angle.degrees(rotation),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .scaleEffect(scale)
                }
                .padding(.horizontal, 60)
                
                VStack(spacing: 20) {
                    // Rotation slider
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Rotate", systemImage: "rotate.3d")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Slider(value: $rotation, in: 0...360)
                            .frame(maxWidth: 400)
                    }
                    
                    // Scale slider
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Scale", systemImage: "arrow.up.left.and.arrow.down.right")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Slider(value: $scale, in: 0.5...1.5)
                            .frame(maxWidth: 400)
                    }
                }
                .padding(.horizontal, 60)
            }
            
            CaptionLabel(text: "You'll curate your own room later.")
                .padding(.top, 10)
            
            Spacer()
            
            PrimaryButton(title: "Looks good", action: onContinue)
                .padding(.bottom, 60)
        }
    }
}

#Preview {
    CabinetIntroStepView(artifact: .sample, onContinue: {})
}

