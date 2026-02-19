//
//  GameStateManager.swift
//  Play Whot
//
//  Created by Kensei on 2026-02-18.
//

// MARK: - State Manager
enum GameStateManager {
    case waitingForPlay
    case resolvingEffect
    case waitingForShape
    case gameOver
    
// MARK: - Effect handler
    
}
enum CardEffect {
    case none
    case skip
    case whot
}

// MARK: - Shapes Manager
enum Shape: CaseIterable {
    case square
    case triangle
    case circle
    case cross
    case star
    case special
}
