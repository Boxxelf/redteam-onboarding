//
//  ScanTutorialStepView.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 10/1/25.
//

import SwiftUI
import RealityKit

/// Second step: Scan tutorial with long-press interaction
struct ScanTutorialStepView: View {
    let onScanComplete: () -> Void
    
    @State private var isScanning = false
    @State private var pulseScale: CGFloat = 1.0
    
    var body: some View {
        VStack(spacing: 60) {
            Spacer()
            
            ZStack {
                // 3D Tea Bowl model
                Model3D(named: "tang_glaze") { model in
                    model
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                } placeholder: {
                    ProgressView()
                }
                .opacity(0.5)
                
                // Pulsing reticle overlay
                Circle()
                    .strokeBorder(Color.accentColor, lineWidth: 3)
                    .frame(width: 250, height: 250)
                    .scaleEffect(pulseScale)
                    .opacity(2 - pulseScale)
                    .animation(
                        .easeInOut(duration: 1.5).repeatForever(autoreverses: false),
                        value: pulseScale
                    )
            }
            .onAppear {
                pulseScale = 1.8
            }
            
            VStack(spacing: 16) {
                if isScanning {
                    ProgressView()
                        .scaleEffect(1.2)
                    Text("Scanning...")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                } else {
                    Text("Hold to scan")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    CaptionLabel(text: "Press and hold on the object")
                }
            }
            
            Spacer()
        }
        .contentShape(Rectangle())
        .onLongPressGesture(minimumDuration: 1.5) {
            performScan()
        }
        .accessibilityLabel("Long press to scan object")
        .accessibilityHint("Press and hold to scan the cup")
    }
    
    private func performScan() {
        guard !isScanning else { return }
        isScanning = true
        
        // Trigger the scan in AppModel
        Task {
            // The parent will handle the actual scan via AppModel
            try? await Task.sleep(nanoseconds: 100_000_000) // Small delay for UI feedback
            onScanComplete()
        }
    }
}

#Preview {
    ScanTutorialStepView(onScanComplete: {})
}

