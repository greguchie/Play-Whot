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
        updateHand()
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        if let cardSelected = playerOneHand.getSelectedCard(from: myGame.player1.hand){
            let movePlayed = myGame.playMove(cardSelected: cardSelected)
            if movePlayed {
                playerOneHand.show(cards: myGame.currentPlayer.hand)
                updateTable()
                updateHand()
            }
        } else {return}
    }
    @IBAction func marketPressed(_ sender: Any) {
        myGame.goMarket()
        updateTable()
        updateHand()
    }
    
    
    func updateTable() {
        tableCard.image = UIImage(named: "\(myGame.tableCard.shape)\(myGame.tableCard.number)")
    }
    
    func updateHand (){
        playerOneHand.show(cards: myGame.currentPlayer.hand)
    }
    
}

