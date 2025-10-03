//
//  TransformationStepView.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 10/1/25.
//

import SwiftUI
import RealityKit

/// Third step: Visual transformation animation
struct TransformationStepView: View {
    let onContinue: () -> Void
    
    @State private var showContinue = false
    @State private var animationScale: CGFloat = 0.5
    @State private var animationOpacity: Double = 0.0
    @State private var particlesOpacity: Double = 0.0
    
    var body: some View {
        ZStack {
            // RealityView for particles (minimal implementation)
            RealityView { content in
                // TODO: Add particle system when implementing full 3D
                // For now, keeping it minimal for simulator compatibility
            }
            .opacity(particlesOpacity)
            
            VStack(spacing: 60) {
                Spacer()
                
                // Transformation animation
                ZStack {
                    // "Before" object fading out (plain version)
                    Model3D(named: "tang_glaze") { model in
                        model
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 180)
                    } placeholder: {
                        ProgressView()
                    }
                    .opacity(1.0 - animationOpacity)
                    .grayscale(1.0)
                    
                    // "After" artifact appearing (with glow effect)
                    Model3D(named: "tang_glaze") { model in
                        model
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                    } placeholder: {
                        ProgressView()
                    }
                    .scaleEffect(animationScale)
                    .opacity(animationOpacity)
                }
                
                VStack(spacing: 16) {
                    Text("Transformation unlocked")
                        .font(.title)
                        .fontWeight(.bold)
                        .opacity(animationOpacity)
                    
                    if showContinue {
                        PrimaryButton(title: "Continue", action: onContinue)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
                
                Spacer()
            }
        }
        .onAppear {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        // Phase 1: Scale and fade in artifact (1s)
        withAnimation(.easeOut(duration: 1.0)) {
            animationScale = 1.2
            animationOpacity = 1.0
            particlesOpacity = 1.0
        }
        
        // Phase 2: Settle to normal scale (0.5s)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                animationScale = 1.0
            }
        }
        
        // Phase 3: Show continue button (1.5s total)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeIn(duration: 0.3)) {
                showContinue = true
            }
        }
    }
}

#Preview {
    TransformationStepView(onContinue: {})
}

