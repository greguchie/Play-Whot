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
        updateTableUI()
        updateHandsUI()
        
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        if let cardSelected = playerOneHand.getSelectedCard(from: myGame.player1.hand) {
            let movePlayed = myGame.playMove(cardSelected: cardSelected)
            if movePlayed {
                if myGame.tableCard.number == 20 {
                    presentShapeRequest()
                }
                updateTableUI()
                updateHandsUI()
                
            }
        }
        else {
            print("no card selected")
        }
    }
    
    @IBAction func player2play(_ sender: Any) {
        if let cardSelected = playerTwoHand.getSelectedCard(from: myGame.player2.hand){
            let movePlayed = myGame.playMove(cardSelected: cardSelected)
            if movePlayed {
                updateTableUI()
                updateHandsUI()
                if myGame.tableCard.number == 20 {
                    presentShapeRequest()
                }
            }
        }
    }
    @IBAction func marketPressed(_ sender: Any) {
        myGame.goMarket()
        updateHandsUI()
    }
    
    
    func updateTableUI() {
        tableCard.image = UIImage(named: "\(myGame.tableCard.shape)\(myGame.tableCard.number)")
    }
    
    func updateHandsUI (){
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
                self.updateTableUI()
                self.updateHandsUI()
                print("player has requested \(shape)")
            })
        }
        
        present(alert, animated: true)
    }
    
    
}

