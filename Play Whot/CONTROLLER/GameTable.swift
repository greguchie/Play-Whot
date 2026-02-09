//
//  ViewController.swift
//  Play Whot
//
//  Created by Kensei on 2026-02-09.
//

import UIKit

class GameTable: UIViewController {
  
    
    
    @IBOutlet weak var playerOneHand: HandView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let images:[UIImage] = [
            UIImage(named: "circle2")!,
            UIImage(named: "square14")!,
            UIImage(named: "circle10")!,
            UIImage(named: "square7")!,
            UIImage(named: "star2")!,
        ]
        
        playerOneHand.show(images: images)
    }
    

}

