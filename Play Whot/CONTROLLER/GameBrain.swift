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
    let player2: Player
    
    private(set) var tableCard: Card
    private(set) var currentPlayer: Player
    private(set) var market: [Card]
    private(set) var tableCardHistory: [Card]  = []
    var requestedShape: Shape?
    
    
    init() {
        //when a deck is created, it is first shuffled by the game
        var deck = Deck()
        print(deck.groupOfCards.count)
        deck.shuffle()
        
        //now each player is deal 7 cards each from the shuffled deck. note this turns the player.hasWon property false even though we are not using the property now
        player1 = Player(name: "kachi", hand: deck.dealAHand(5))
        player2 = Player(name: "ebuka", hand: deck.dealAHand(5))
        
        //game places a random card from the current deck of cards created, and player one becomes first player
        tableCard = deck.groupOfCards.randomElement()!
        currentPlayer = player1
        //storemarket for use and reshuffling
        tableCardHistory.append(tableCard)
        market = deck.groupOfCards
    }
    
    func playMove(cardSelected: Card) -> Bool {
        requestWhotReset()
        // If a WHOT request is active, enforce playing the requested shape
        if RuleEngine.isWhotRequest(tableCard) {
            guard RuleEngine.checkWhotPlay(requestedShape, cardSelected) || RuleEngine.cardIs20(cardSelected)
            else {
                print("please play requested shape or GO GEN.!")
                return false
            }
            if let index = currentPlayer.hand.firstIndex(of: cardSelected) {
                currentPlayer.hand.remove(at: index)
                updateTableCard(cardSelected)
            }
        }
        else if RuleEngine.isValidMove(card: cardSelected, tableCard: tableCard) {
            // valid normal move; proceed
            if let index = currentPlayer.hand.firstIndex(of: cardSelected) {
                currentPlayer.hand.remove(at: index)
            }
            // Update the table card and reset any pending request
            updateTableCard(cardSelected)
        }
        else {
            print("Invalid move. Please try again or go market")
            return false
        }
        return true
    }
    
    func goMarket(){
        if market.count > 0 {
            let marketCard = market.removeFirst()
            currentPlayer.hand.insert(marketCard, at: 0)
            print ("\(currentPlayer.name) went ot market, remaining cards: \(market.count) total")
        } else {
            print("no cards left in market")
        }
        switchTurn()
    }
    
    func forcedMarket(player: Player){
        if market.count > 0 {
            let marketCard = market.removeFirst()
            player.hand.insert(marketCard, at: 0)
            print ("remaining cards: \(market.count) total")
        } else {
            print("no cards left in market")
        }
    }
    
    func setRequestedShape(_ shape: Shape) {
        //will be set by UI or CPU
        requestedShape = shape
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
    }
    
    func performActions() {
        let opponent = (currentPlayer === player1) ? player2 : player1
        if tableCard.number == 1 {
            // opponent skips turn
        }
        if tableCard.number == 2 {
            print("\(opponent.name) pick two and skip turn")
            forcedMarket(player: opponent)
            forcedMarket(player: opponent)
        }
        if tableCard.number == 14 {
            print("\(opponent.name) go gen and skip turn")
            forcedMarket(player: opponent)
        }
    }
}

