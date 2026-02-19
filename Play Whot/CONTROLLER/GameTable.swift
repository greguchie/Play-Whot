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
        guard myGame.currentPlayer === myGame.player1
        else {
            print("wait your turn kachi")
            return}
        if let cardSelected = playerOneHand.getSelectedCard(from: myGame.player1.hand) {
            myGame.playMove(cardSelected: cardSelected)
            handlePostPlayState()
            updateTableUI()
            updateHandsUI()
            checkForCPUTurn()
            
        }
        else {
            print("no card selected")
        }
    }
    
//    @IBAction func play2(_ sender: Any) {
//        guard myGame.currentPlayer === myGame.player2
//        else {
//            print("wait your turn ebuka")
//            return}
//        if let cardSelected = playerTwoHand.getSelectedCard(from: myGame.player2.hand) {
//            if cardSelected.number == 20 {
//                presentShapeRequest()
//            }
//            myGame.playMove(cardSelected: cardSelected)
//            updateTableUI()
//            updateHandsUI()
//            
//        }
//        else {
//            print("no card selected")
//        }
//    }
    @IBAction func marketPressed(_ sender: Any) {
        myGame.goMarket()
        updateHandsUI()
        checkForCPUTurn()
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
                print("kachi has requested \(shape)")
                self.checkForCPUTurn()
            })
        }
        
        present(alert, animated: true)
        
    }
    
    func checkForCPUTurn() {
        guard myGame.currentPlayer is CPUPlayer else { return }
        // Disable human interaction during CPU turn
        playerTwoHand.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.myGame.performCPUTurn()
            self.updateTableUI()
            self.updateHandsUI()
            // If still CPU turn (due to skip cards etc)
            self.checkForCPUTurn()
            
            // Re-enable interaction if turn switched
            if !(self.myGame.currentPlayer is CPUPlayer) {
                self.playerTwoHand.isUserInteractionEnabled = true
            }
        }
    }
    
    private func handlePostPlayState() {
        switch myGame.gameState {
        case .waitingForShape:
            presentShapeRequest()
        default:
            break
        }
    }
}

