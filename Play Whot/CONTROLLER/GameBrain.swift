//
//  GameBrain.swift
//  Play Whot
//
//  Created by Kensei on 2026-02-09.
//

import Foundation
import UIKit

class GameBrain {
    let player1: Player
    let player2: CPUPlayer
    
    private(set) var tableCard: Card
    private(set) var currentPlayer: Player
    private(set) var market: [Card]
    private(set) var tableCardHistory: [Card]  = []
    var requestedShape: Shape?
    var gameState: GameStateManager = .waitingForPlay
    
    
    init() {
        //when a deck is created, it is first shuffled by the game
        var deck = Deck()
        print("market has \(deck.market.count) cards")
        deck.shuffle()
        
        //now each player is deal 7 cards each from the shuffled deck. note this turns the player.hasWon property false even though we are not using the property now
        player1 = Player(name: "kachi", hand: deck.dealAHand(5))
        //player2 = Player(name: "ebuka", hand: deck.dealAHand(22))
        player2 = CPUPlayer(name: "Randy", hand: deck.dealAHand(5))
        
        //game places a random card from the current deck of cards created, and player one becomes first player
        tableCard = deck.market.randomElement()!
        currentPlayer = player1
        //storemarket for use and reshuffling
        tableCardHistory.append(tableCard)
        market = deck.market
    }
    
    func playMove(cardSelected: Card) {
        requestWhotReset()//resets to nil if its not a 20 at table from previous play
        
        guard gameState == .waitingForPlay
        else {
            print("wait your turn")
            return }
        // If a WHOT request is active, enforce playing the requested shape
        if RuleEngine.isWhotRequest(tableCard) {
            guard RuleEngine.checkWhotPlay(requestedShape, cardSelected) ||
                    RuleEngine.cardIs20(cardSelected)
                    //if a valid whot request is playerd or if another whot is to be played
            else {
                print("please play requested shape or GO GEN.!")
                return
            }
            if let index = currentPlayer.hand.firstIndex(of: cardSelected) {
                if currentPlayer.hand.contains(cardSelected){
                    currentPlayer.hand.remove(at: index)
                }
                else {
                    print("card not in hand")
                }
            }
        }
        else if RuleEngine.isValidMove(card: cardSelected, tableCard: tableCard) {
            // valid normal move; proceed
            if let index = currentPlayer.hand.firstIndex(of: cardSelected) {
                currentPlayer.hand.remove(at: index)
            }
            // Update the table card and reset any pending request
            
        }
        else {
            print("Invalid move. Please try again or go market")
            return
        }
        updateTableCard(cardSelected)
        gameState = .resolvingEffect
        applyCardEffect(tableCard)
    }
    
    func performCPUTurn(){
        requestWhotReset()
        guard let cpu = currentPlayer as? CPUPlayer else { return }
        if let cardselected = cpu.chooseMove(tableCard: tableCard, shapeRequested: requestedShape) {
            playMove(cardSelected: cardselected)
            switch gameState {
            case .waitingForShape:
                let cpuShape = cpu.chooseRequestedShape()
                setRequestedShape(cpuShape)
                print("\(currentPlayer) requests \(cpuShape)")
            default:
                break
            }
        }
        else {
            //cpu go market
            goMarket()
        }
        
    }
    
    
    func goMarket(){
        if market.count > 0 {
            let marketCard = market.removeFirst()
            currentPlayer.hand.insert(marketCard, at: 0)
            print("\(currentPlayer.name) goes to market")
            print ("\(player2.name): \(player2.hand.count) cards\nkachi: \(player1.hand.count) cards")
        } else {
            print("no cards left in market")
        }
        endTurn()
    }
    
    private func forcedMarket(player: Player){
        if market.count > 0 {
            let marketCard = market.removeFirst()
            player.hand.insert(marketCard, at: 0)
            print ("\(player2.name): \(player2.hand.count) cards\nkachi: \(player1.hand.count) cards")
            print ("remaining cards: \(market.count) total")
        } else {
            print("no cards left in market")
        }
    }
    
    func setRequestedShape(_ shape: Shape) {
        //will be set by UI or CPU and turn ends
        requestedShape = shape
        endTurn()
    }
    
    func updateTableCard(_ card: Card) {
        //store previous table card
        tableCardHistory.append(tableCard)
        //update current played card after passing rule engine
        tableCard = card
    }
    
    func requestWhotReset(){
        //resets nil value of whotrequest, if request is granted
        if !RuleEngine.isWhotRequest(tableCard) {
            requestedShape = nil
        }
    }
    
    func switchTurn(){
        currentPlayer = (currentPlayer === player1) ? player2 : player1
        print("current player is now \(currentPlayer.name)")
    }
    
    private func applyCardEffect(_ card: Card) {
        let opponent = (currentPlayer === player1) ? player2 : player1
        switch card.effect {
        case .skip:
            print("turn skipped")
            if card.number == 1 {
                
                handleSkip()
            }
            if card.number == 2 {
                print("pick two! \(opponent.name)")
                forcedMarket(player: opponent)
                forcedMarket(player: opponent)
                handleSkip()
            }
            if card.number == 14{
                print("go gen \(opponent.name)")
                forcedMarket(player: opponent)
                handleSkip()
            }
        case .whot:
            //here UI or CPU will pick will call setRequestedShape() which ends turns
            gameState = .waitingForShape
            return
        case .none:
            endTurn()
        }
    }
    
    func handleSkip() {
        //dont skip, just reset state to waiting for play again
        gameState = .waitingForPlay
    }
    func endTurn() {
        switchTurn()
        //requestedShape = nil
        gameState = .waitingForPlay
        print("\(currentPlayer.name) make a move")
    }
}

