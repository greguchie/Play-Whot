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
    private(set) var requestedShape: Shape?

    
    init() {
        //when a deck is created, it is first shuffled by the game
        var deck = Deck()
        print(deck.groupOfCards.count)
        deck.shuffle()
        
        //now each player is deal 7 cards each from the shuffled deck. note this turns the player.hasWon property false even though we are not using the property now
        player1 = Player(hand: deck.dealAHand(6))
        player2 = Player(hand: deck.dealAHand(6))
        
        //game places a random card from the current deck of cards created, and player one becomes first player
        tableCard = deck.groupOfCards.randomElement()!
        currentPlayer = player1
        market = deck.groupOfCards
    }
    
    func playMove(cardSelected: Card) -> Bool {
        //note: a move is an input, will be provided by UI upon interation
        //check if this is a valid move
        guard
            //game continues if true
            RuleEngine.isValidMove(card: cardSelected,
                                   tableCard: tableCard,
                                   whotRequest: requestedShape)
        else {
            //game asks for a valid move if false
            print("please make a valid move or GO GEN.!")
            return false
        }
        
        //Remove cards from player
        if let index = currentPlayer.hand.firstIndex(of: cardSelected) {
            currentPlayer.hand.remove(at: index)
            
        }
        
        // played card placed on table
        tableCard = cardSelected
        //check for 1, 2, 14 and 20
        let opponent = (currentPlayer === player1) ? player2 : player1
        if tableCard.number == 1 {
            print("hold on, player 2 skips a turn")
            //turn skipped, no switch (i.e. currentplayer = opponent)
            return true
        }
        if tableCard.number == 2 {
            print("pick two, player 2 take 2 cards from market and skips a turn")
            forcedMarket(player: opponent)
            forcedMarket(player: opponent)
            //turn skipped, no switch (i.e. currentplayer = opponent)
            return true
        }
        if tableCard.number == 14 {
            print("GO GEN, player 2 picks from the market, and skips a turn")
            forcedMarket(player: opponent)
            //turn skipped, no switch (i.e. currentplayer = opponent)
            return true
        }
        if tableCard.number == 20 {
            print("I need ...")
            return true
        }
        
        requestedShape = nil
        // Switch turn (off for now)
        currentPlayer = (currentPlayer === player1) ? player2 : player1
        
        return true
    }
    
    func goMarket(){
        if market.count > 0 {
            let marketCard = market.removeFirst()
            currentPlayer.hand.insert(marketCard, at: 0)
            print ("remaining cards: \(market.count) total")
        } else {
            print("no cards left in market")
        }
        //switches turns by default
        currentPlayer = (currentPlayer === player1) ? player2 : player1
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
        requestedShape = shape
        // Switch turn AFTER shape is chosen (off for now)
        currentPlayer = (currentPlayer === player1) ? player2 : player1
    }
    
    
}
