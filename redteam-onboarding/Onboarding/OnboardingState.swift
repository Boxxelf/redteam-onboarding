//
//  OnboardingState.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 10/1/25.
//

import SwiftUI
import Combine

enum ScanSize: String, CaseIterable, Identifiable {
    case small, medium, large
    var id: String { rawValue }
    var title: String {
        switch self {
        case .small: return "Small Object"
        case .medium: return "Medium Object"
        case .large: return "Large Object"
        }
    }
    var hint: String {
        switch self {
        case .small: return "≈ a ping-pong ball"
        case .medium: return "≈ a water bottle"
        case .large: return "≈ a backpack"
        }
    }
}

enum Region: String, CaseIterable, Identifiable {
    case eastAsia = "East Asia"
    case europe = "Europe"
    case middleEast = "Middle East"
    case southAsia = "South Asia"
    case africa = "Africa"
    case americas = "Americas"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .eastAsia: return "globe.asia.australia"
        case .europe: return "globe.europe.africa"
        case .middleEast: return "sun.max"
        case .southAsia: return "mountain.2"
        case .africa: return "leaf"
        case .americas: return "globe.americas"
        }
    }
    
    var description: String {
        switch self {
        case .eastAsia: return "Ancient China, Japan, Korea"
        case .europe: return "Classical Greece, Rome, Medieval"
        case .middleEast: return "Mesopotamia, Persia, Arabia"
        case .southAsia: return "India, Sri Lanka, Southeast Asia"
        case .africa: return "Egypt, Nubia, Mali Empire"
        case .americas: return "Maya, Aztec, Inca Civilizations"
        }
    }
}

struct OnboardingArtifact: Identifiable {
    let id = UUID()
    let name: String
    let era: String
    let region: Region
    let description: String
    let modelName: String?
    let audioName: String?
    
    static let samples: [Region: OnboardingArtifact] = [
        .eastAsia: OnboardingArtifact(
            name: "Tang Dynasty Tea Bowl",
            era: "618-907 CE",
            region: .eastAsia,
            description: "A delicate porcelain bowl from the golden age of Chinese ceramics.",
            modelName: "tang_glaze",
            audioName: "tang_glaze_audio"
        ),
        .europe: OnboardingArtifact(
            name: "Roman Amphora",
            era: "27 BCE - 476 CE",
            region: .europe,
            description: "A terracotta vessel used for storing wine and olive oil.",
            modelName: "roman_amphora",
            audioName: "roman_amphora_audio"
        ),
        .middleEast: OnboardingArtifact(
            name: "Persian Carpet Fragment",
            era: "1501-1736 CE",
            region: .middleEast,
            description: "Intricate wool weaving from the Safavid dynasty.",
            modelName: "persian_carpet",
            audioName: "persian_carpet_audio"
        ),
        .southAsia: OnboardingArtifact(
            name: "Buddhist Stupa",
            era: "3rd Century BCE",
            region: .southAsia,
            description: "A sacred monument containing relics of the Buddha.",
            modelName: "buddhist_stupa",
            audioName: "buddhist_stupa_audio"
        ),
        .africa: OnboardingArtifact(
            name: "Nubian Gold Ring",
            era: "1070-350 BCE",
            region: .africa,
            description: "Crafted by the ancient kingdom of Kush.",
            modelName: "nubian_ring",
            audioName: "nubian_ring_audio"
        ),
        .americas: OnboardingArtifact(
            name: "Maya Jade Mask",
            era: "250-900 CE",
            region: .americas,
            description: "A ceremonial mask from the Classic Maya period.",
            modelName: "maya_mask",
            audioName: "maya_mask_audio"
        )
    ]
}

final class OnboardingModel: ObservableObject {
    @Published var completed: Set<ScanSize> = []
    @Published var isScanning: Bool = false
    @Published var lastScan: ScanSize?
    @Published var selectedRegion: Region?
    @Published var selectedArtifact: OnboardingArtifact?
    @Published var currentStep: OnboardingStep = .welcome
    @Published var scanCount: Int = 0

    var isAllDone: Bool { completed.count == ScanSize.allCases.count }
    var isAllScansComplete: Bool { scanCount >= 3 }

    func markScanned(_ size: ScanSize) {
        completed.insert(size)
        lastScan = size
    }

    @MainActor
    func simulateScan(_ size: ScanSize) async {
        guard !isScanning else { return }
        isScanning = true
        try? await Task.sleep(nanoseconds: 1_200_000_000) // 1.2s mock
        markScanned(size)
        scanCount += 1
        isScanning = false
    }

    func selectRegion(_ region: Region) {
        selectedRegion = region
        selectedArtifact = OnboardingArtifact.samples[region]
        // Don't change currentStep here - let the calling view handle navigation
    }

    func reset() {
        completed.removeAll()
        lastScan = nil
        selectedRegion = nil
        selectedArtifact = nil
        currentStep = .welcome
        scanCount = 0
    }
}