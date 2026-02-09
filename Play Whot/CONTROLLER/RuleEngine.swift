//
//  RuleEngine.swift
//  Play Whot
//
//  Created by Kensei on 2026-02-09.
//

// this is created to check the game after each player makes a moves
struct RuleEngine {
    static func isValidMove(card: Card, tableCard: Card) -> Bool {
        let cardPlay = card
        return matchesShape(cardPlay, tableCard) || matchesNumber(cardPlay, tableCard)
    }
    
    // MARK: - for Single Move
    private static func matchesShape(_ card: Card, _ table: Card) -> Bool {
        //check shape equality
        return card.shape == table.shape
    }
    
    private static func matchesNumber(_ card: Card, _ table: Card) -> Bool {
        //check number eqaulity
        return card.number == table.number
    }
}

