//
//  HomePlaceholderView.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 10/1/25.
//

import SwiftUI
import RealityKit

/// Post-onboarding home view showing the user's first artifact
struct HomePlaceholderView: View {
    @Environment(AppModel.self) private var appModel
    
    var body: some View {
        VStack(spacing: 40) {
            Text("ReSee")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            if let firstArtifact = appModel.collection.first {
                VStack(spacing: 30) {
                    // Artifact display (3D Tea Bowl)
                    Model3D(named: "tang_glaze") { model in
                        model
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                    } placeholder: {
                        ProgressView()
                            .scaleEffect(1.5)
                    }
                    
                    VStack(spacing: 12) {
                        Text(firstArtifact.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("\(appModel.collection.count) artifact\(appModel.collection.count == 1 ? "" : "s") in your Cabinet")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(40)
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 60)
            } else {
                VStack(spacing: 20) {
                    Image(systemName: "tray")
                        .font(.system(size: 80))
                        .foregroundStyle(.secondary)
                    
                    Text("Your Cabinet is empty")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            PrimaryButton(title: "Start Exploring") {
                // TODO: Navigate to main app experience
                print("🚀 Starting main app experience")
            }
            .padding(.bottom, 40)
            
            // Debug reset button (remove in production)
            Button("Reset Onboarding") {
                appModel.resetOnboarding()
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(.bottom, 20)
        }
        .padding()
    }
}

#Preview {
    HomePlaceholderView()
        .environment(AppModel())
}

