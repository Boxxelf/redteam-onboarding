//
//  AppModel.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 9/30/25.
//

import SwiftUI

/// Maintains app-wide state including onboarding flow and artifact collection
@MainActor
@Observable
class AppModel {
    // MARK: - Immersive Space (existing functionality)
    let immersiveSpaceID = "ImmersiveSpace"
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    var immersiveSpaceState = ImmersiveSpaceState.closed
    
    // MARK: - Onboarding State
    var currentStep: OnboardingStep = .welcome
    var hasCompletedOnboarding: Bool = false
    var hasSeenSocialNudge: Bool = false
    
    // MARK: - Artifact Collection
    var collection: [Artifact] = []
    var lastScannedArtifact: Artifact?
    
    // MARK: - Services
    private let recognitionService: ArtifactRecognitionService
    
    // MARK: - Initialization
    init(recognitionService: ArtifactRecognitionService = MockArtifactRecognitionService()) {
        self.recognitionService = recognitionService
    }
    
    // MARK: - Onboarding Navigation
    
    /// Advances to the next onboarding step
    func nextStep() {
        guard currentStep != .finish else {
            completeOnboarding()
            return
        }
        currentStep.next()
    }
    
    /// Goes back to the previous onboarding step (if allowed)
    func prevStep() {
        currentStep.previous()
    }
    
    /// Initiates mock artifact scan
    func startScan() async {
        lastScannedArtifact = await recognitionService.mockScan()
    }
    
    /// Adds the last scanned artifact to the collection
    func addToCabinet() {
        guard let artifact = lastScannedArtifact else { return }
        
        // Avoid duplicates
        guard !collection.contains(where: { $0.id == artifact.id }) else {
            print("⚠️ Artifact already in collection")
            return
        }
        
        collection.append(artifact)
        print("✅ Added \(artifact.name) to Cabinet. Total: \(collection.count)")
    }
    
    /// Marks onboarding as complete
    func completeOnboarding() {
        hasCompletedOnboarding = true
        print("🎉 Onboarding completed!")
    }
    
    /// Resets onboarding state (for debugging)
    func resetOnboarding() {
        currentStep = .welcome
        hasCompletedOnboarding = false
        hasSeenSocialNudge = false
        collection.removeAll()
        lastScannedArtifact = nil
        print("🔄 Onboarding reset")
    }
}
