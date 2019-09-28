//
//  ViewController.swift
//  Set
//
//  Created by Cao Trong Duy Nhan
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import UIKit

@IBDesignable
class SetViewController: UIViewController {

    
    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet var deckView: DeckView!
    
    @IBAction func chooseCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            deckView.chooseCard(at: sender.location(in: deckView))
        default:
            break
        }
        scoreLabel.text = "\(deckView.numberOfCardsLeft)/81"
    }
    
    @IBAction func plus3cards(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .down:
            deckView.plus3cards()
        default:
            break
        }
    }
    
    @IBAction func shuffleCardsOnTable(_ sender: UIRotationGestureRecognizer) {
        switch sender.state {
        case .ended:
            deckView.shuffleCardsOnTable()
        default:
            break
        }
    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        deckView.setUp()
        scoreLabel.text = "\(deckView.numberOfCardsLeft)/81"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deckView.setUp()
    }
    
}

