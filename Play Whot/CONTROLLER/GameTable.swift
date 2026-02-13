//
//  ViewController.swift
//  Play Whot
//
//  Created by Kensei on 2026-02-09.
//

import UIKit

class GameTable: UIViewController {
    
    
    @IBOutlet weak var playerOneHand: HandView!
    @IBOutlet weak var playerTwoHand: HandView!
    @IBOutlet weak var tableCard: UIImageView!
    var myGame = GameBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateTable()
        updateHands()
        
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        if myGame.currentPlayer === myGame.player1 {
            if let cardSelected = playerOneHand.getSelectedCard(from: myGame.player1.hand){
                let movePlayed = myGame.playMove(cardSelected: cardSelected)
                if movePlayed {
                    updateTable()
                    updateHands()
                    if myGame.tableCard.number == 20 {
                        presentShapeRequest()
                    }
                }
            } else {return}
        }
        else {
            print("player 1, wait you turn")
        }
    }
    @IBAction func play2Pressed(_ sender: Any) {
        if myGame.currentPlayer === myGame.player2 {
            if let cardSelected = playerTwoHand.getSelectedCard(from: myGame.player2.hand){
                let movePlayed = myGame.playMove(cardSelected: cardSelected)
                if movePlayed {
                    updateTable()
                    updateHands()
                    if myGame.tableCard.number == 20 {
                        presentShapeRequest()
                    }
                }
            } else {return}
        }
        else {
            print("player 2, wait you turn")
        }
    }
    
    @IBAction func marketPressed(_ sender: Any) {
        myGame.goMarket()
        updateTable()
        updateHands()
    }
    
    
    func updateTable() {
        tableCard.image = UIImage(named: "\(myGame.tableCard.shape)\(myGame.tableCard.number)")
    }
    
    func updateHands (){
        playerOneHand.show(cards: myGame.player1.hand)
        playerTwoHand.show(cards: myGame.player2.hand)
    }
    
    func presentShapeRequest() {
        let alert = UIAlertController(
            title: "What Shape you need?",
            message: nil,
            preferredStyle: .actionSheet
        )

        for shape in Shape.allCases where shape != .special {
            alert.addAction(UIAlertAction(title: "\(shape)", style: .default) { _ in
                self.myGame.setRequestedShape(shape)
                self.updateTable()
                self.updateHands()
                print("player has requested \(shape)")
            })
        }

        present(alert, animated: true)
    }

    
}

