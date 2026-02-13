//
//  RuleEngine.swift
//  Play Whot
//
//  Created by Kensei on 2026-02-09.
//

// this is created to check the game after each player makes a moves
struct RuleEngine {
    static func isValidMove(card: Card,
                            tableCard: Card,
                            whotRequest: Shape?) -> Bool {
        // if nill, code is skipped
        if let shapeForced = whotRequest {
            //returns true if play card shape matches a requested shape
            return card.shape == shapeForced
        }
        //check for standard shape/number match
        let cardMatch = matchesShape(card, tableCard) || matchesNumber(card, tableCard)
        //allow special20 to be played at anytime of the game
        let isSpecial = card.shape == .special
        return cardMatch || isSpecial
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


// MARK: - IMPLEMENT HOLDON, PICK TWO, GEN & I NEED
