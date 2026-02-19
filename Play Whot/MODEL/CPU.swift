//
//  CPU.swift
//  Play Whot
//
//  Created by Kensei on 2026-02-19.
//

class CPUPlayer: Player {
    
    // MARK: - Choose a Move
    func chooseMove(tableCard: Card, shapeRequested: Shape?) -> Card? {
        //CPU will choose a random card from a group of 20s and valid move cards
        var possiblePlay: [Card] = []
        if RuleEngine.cardIs20(tableCard) {
            // means whot is in play
            possiblePlay += self.hand.filter {RuleEngine.checkWhotPlay(shapeRequested, $0)}
        }
        else if shapeRequested == nil {
            // whot not in play, just match the card normally
            possiblePlay += self.hand.filter {RuleEngine.isValidMove(card: $0, tableCard: tableCard)}
        }
        if let cardPlay = possiblePlay.randomElement() {
            return cardPlay
        }
        else {
            return nil
        }
        
    }
    
    // MARK: - Choose Shape for 20
    
    func chooseRequestedShape() -> Shape {
        //out of a list of all shaped computer has excluding whot shaped, pick a random one
        var distinctShapes: [Shape] = Array(Set(self.hand.map(\.shape)))
        if let index = distinctShapes.firstIndex(of: .special) {
            distinctShapes.remove(at: index)
        }
        if let chosenShape = distinctShapes.randomElement() {
            return chosenShape
        }
        return .circle
    }
}

