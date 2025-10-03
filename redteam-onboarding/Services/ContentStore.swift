//
//  ContentStore.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 10/1/25.
//

import Foundation

/// Loads and manages local artifact content
final class ContentStore: @unchecked Sendable {
    
    private(set) var artifacts: [Artifact] = []
    
    init() {
        loadArtifacts()
    }
    
    /// Loads artifacts from the bundled JSON file
    private func loadArtifacts() {
        guard let url = Bundle.main.url(forResource: "Artifacts", withExtension: "json") else {
            print("⚠️ Artifacts.json not found in bundle")
            artifacts = [Artifact.sample]
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            artifacts = try decoder.decode([Artifact].self, from: data)
            print("✅ Loaded \(artifacts.count) artifact(s)")
        } catch {
            print("⚠️ Failed to load artifacts: \(error)")
            artifacts = [Artifact.sample]
        }
    }
}

