//
//  RuleEngine.swift
//  Play Whot
//
//  Created by Kensei on 2026-02-09.
//

// this is created to check the game after each player makes a moves
struct RuleEngine {
    static func isValidMove(card: Card,
                            tableCard: Card,) -> Bool {
        let cardMatch = matchesShape(card, tableCard) || matchesNumber(card, tableCard)
        //allow special20 to be played at anytime of the game
        let isSpecial20 = cardIs20(card)
        return cardMatch || isSpecial20
    }
    // check if played table card is whot20
    static func isWhotRequest(_ tableCard: Card) -> Bool{
        return tableCard.shape == .special
    }
    static func checkWhotPlay(_ whotRequest:Shape?, _ card:Card) -> Bool {
        if let forcedShape = whotRequest {
            return card.shape == forcedShape
        }
        return false
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
    
    //        // check starting card
    static func cardIs20(_ card: Card) -> Bool {
        return card.number == 20
    }
}


// MARK: - IMPLEMENT HOLDON, PICK TWO, GEN & I NEED




