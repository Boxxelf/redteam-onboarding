//
//  ArtifactRecognitionService.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 10/1/25.
//

import Foundation

/// Protocol for artifact recognition services
protocol ArtifactRecognitionService {
    func mockScan() async -> Artifact
}

/// Mock implementation for onboarding flow
/// TODO: Replace with ARKit/ML object recognition
final class MockArtifactRecognitionService: ArtifactRecognitionService, @unchecked Sendable {
    
    private let contentStore: ContentStore
    
    init(contentStore: ContentStore = ContentStore()) {
        self.contentStore = contentStore
    }
    
    /// Simulates a scanning process with a delay
    /// Returns a pre-loaded artifact from the content store
    func mockScan() async -> Artifact {
        // Simulate network/processing delay
        try? await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds
        
        // Return the first artifact from our content store
        return contentStore.artifacts.first ?? Artifact.sample
    }
}

