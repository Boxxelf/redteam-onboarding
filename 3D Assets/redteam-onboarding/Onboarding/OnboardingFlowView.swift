//
//  OnboardingFlowView.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 10/1/25.
//

import SwiftUI

/// Main onboarding flow controller with step management
struct OnboardingFlowView: View {
    @Environment(AppModel.self) private var appModel
    
    var body: some View {
        @Bindable var bindableModel = appModel
        
        ZStack {
            // Main content
            TabView(selection: $bindableModel.currentStep) {
                WelcomeStepView(onNext: {
                    appModel.nextStep()
                })
                .tag(OnboardingStep.welcome)
                
                ScanTutorialStepView(onScanComplete: {
                    Task {
                        await appModel.startScan()
                        await MainActor.run {
                            appModel.nextStep()
                        }
                    }
                })
                .tag(OnboardingStep.scanTutorial)
                
                TransformationStepView(onContinue: {
                    appModel.nextStep()
                })
                .tag(OnboardingStep.transform)
                
                if let artifact = appModel.lastScannedArtifact {
                    NarrativeStepView(artifact: artifact, onAddToCabinet: {
                        appModel.addToCabinet()
                        appModel.nextStep()
                    })
                    .tag(OnboardingStep.narrative)
                    
                    CabinetIntroStepView(artifact: artifact, onContinue: {
                        appModel.nextStep()
                    })
                    .tag(OnboardingStep.cabinetIntro)
                }
                
                SocialNudgeStepView(
                    onAccept: {
                        appModel.hasSeenSocialNudge = true
                        appModel.nextStep()
                    },
                    onSkip: {
                        appModel.hasSeenSocialNudge = true
                        appModel.nextStep()
                    }
                )
                .tag(OnboardingStep.socialNudge)
                
                FinishStepView(onComplete: {
                    appModel.completeOnboarding()
                })
                .tag(OnboardingStep.finish)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: appModel.currentStep)
            
            // Progress dots overlay
            VStack {
                StepProgressDots(currentStep: appModel.currentStep)
                    .padding(.top, 40)
                
                Spacer()
            }
            
            // Back button (conditional)
            if appModel.currentStep.canGoBack {
                VStack {
                    HStack {
                        Button(action: {
                            appModel.prevStep()
                        }) {
                            Label("Back", systemImage: "chevron.left")
                                .font(.body)
                                .padding(12)
                                .background(Color.secondary.opacity(0.2))
                                .clipShape(Circle())
                        }
                        .buttonStyle(.plain)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    OnboardingFlowView()
        .environment(AppModel())
}

