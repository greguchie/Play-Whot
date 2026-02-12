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
        playerOneHand.show(cards: myGame.player1.hand)
    }
    //playerOneHand.show(images: myGame.player1.hand)
    
    
    @IBAction func playButtonPressed(_ sender: Any) {
        print(myGame.tableCard)
        print("player 1 card:\(myGame.player1.hand[0].shape)")
    }
    
}

