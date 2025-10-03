//
//  Artifact.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 10/1/25.
//

import Foundation

/// Represents a cultural artifact discovered through scanning
struct Artifact: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let era: String
    let region: String
    let shortDescription: String
    let thumbnailName: String
    let modelName: String?
    
    init(
        id: UUID = UUID(),
        name: String,
        era: String,
        region: String,
        shortDescription: String,
        thumbnailName: String,
        modelName: String? = nil
    ) {
        self.id = id
        self.name = name
        self.era = era
        self.region = region
        self.shortDescription = shortDescription
        self.thumbnailName = thumbnailName
        self.modelName = modelName
    }
}

// MARK: - Sample Data
extension Artifact {
    static let sample = Artifact(
        name: "Tang Dynasty Tea Bowl",
        era: "618-907 CE",
        region: "Chang'an, China",
        shortDescription: "This humble bowl once held tea in the hands of a traveling merchant. Its cracked glaze tells stories of a thousand journeys along the Silk Road.",
        thumbnailName: "artifact_thumb",
        modelName: "tea_bowl"
    )
}

