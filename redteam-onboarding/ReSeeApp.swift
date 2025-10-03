//
//  ReSeeApp.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 10/1/25.
//

import SwiftUI

@main
struct ReSeeApp: App {
    
    @State private var appModel = AppModel()
    @State private var avPlayerViewModel = AVPlayerViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if avPlayerViewModel.isPlaying {
                    AVPlayerView(viewModel: avPlayerViewModel)
                } else {
                    // Route based on onboarding completion
                    if appModel.hasCompletedOnboarding {
                        HomePlaceholderView()
                            .environment(appModel)
                    } else {
                        OnboardingFlowView()
                            .environment(appModel)
                    }
                }
            }
        }
        
        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                    avPlayerViewModel.play()
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                    avPlayerViewModel.reset()
                }
        }
        .immersionStyle(selection: .constant(.progressive), in: .progressive)
    }
}

