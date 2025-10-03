//
//  OnboardingStep.swift
//  redteam-onboarding
//
//  Created by Tina Jiang on 10/1/25.
//

import Foundation

/// Defines the sequential steps in the onboarding flow
enum OnboardingStep: Int, CaseIterable {
    case welcome = 0
    case scanTutorial
    case transform
    case narrative
    case cabinetIntro
    case socialNudge
    case finish
    
    var title: String {
        switch self {
        case .welcome: return "Welcome"
        case .scanTutorial: return "Scan"
        case .transform: return "Transform"
        case .narrative: return "Discover"
        case .cabinetIntro: return "Cabinet"
        case .socialNudge: return "Connect"
        case .finish: return "Ready"
        }
    }
    
    var canGoBack: Bool {
        switch self {
        case .welcome, .transform, .finish:
            return false
        default:
            return true
        }
    }
    
    mutating func next() {
        if let nextStep = OnboardingStep(rawValue: self.rawValue + 1) {
            self = nextStep
        }
    }
    
    mutating func previous() {
        if canGoBack, let prevStep = OnboardingStep(rawValue: self.rawValue - 1) {
            self = prevStep
        }
    }
}

