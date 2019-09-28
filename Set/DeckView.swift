//
//  DeckView.swift
//  Set
//
//  Created by Cao Trong Duy Nhan on 6/24/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import UIKit

@IBDesignable
class DeckView: UIView {

    var numberOfCardsLeft: Int {
        get {
            return game.cardsOnStack.count + game.deck.count
        }
    }
    
    private var game = Set()
    
    private lazy var grid = Grid(layout: Grid.Layout.aspectRatio(CardView.SizeRatio.cardWidthToHeigh))
    
    private var cardOnDeckView = [CardView]()
    {
        didSet {
            redrawCardViews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUp() {
        game = Set()
        updateViewFromModel()
    }
    
    override func draw(_ rect: CGRect) {
        redrawCardViews()
    }
    
    private func createCardViewStack() -> [CardView] {
        var cardViews = [CardView]()
        for card in game.deck {
            if card != nil {
                cardViews.append(CardView())
                cardViews.last!.card = card ?? Card()
                addSubview(cardViews.last!)
            }
        }
        return cardViews
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        redrawCardViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func plus3cards() {
        var count = 3
        while game.cardsOnStack.count > 0 && count > 0 {
            count -= 1
            game.deck.append(game.cardsOnStack.remove(at: 0))
        }
        updateViewFromModel()
    }
    
    func shuffleCardsOnTable() {
        var tempCardStack = [Card]()
        for indexSelected in game.selectedCardIndices {
            tempCardStack.append(game.deck[indexSelected]!)
        }
        game.deck.shuffle()
        
        game.selectedCardIndices.removeAll()
        for card in tempCardStack {
            game.selectedCardIndices.append(game.deck.firstIndex(of: card)!)
        }
        updateViewFromModel()
    }
    
    func chooseCard(at location: CGPoint) {
        
        for indexGrid in 0..<grid.cellCount {
            if grid[indexGrid]!.contains(location) {
                
                if game.isMatched {
                    updateViewFromModel()
                }
                game.chooseCard(at: indexGrid)
                updateViewFromModel()
                
                break
            }
        }
    }
    
    func updateViewFromModel() {
        for viewOfCard in cardOnDeckView {
            viewOfCard.removeFromSuperview()
        }
        cardOnDeckView = createCardViewStack()
    }
    
    private func redrawCardViews() {
        grid.frame = bounds
        grid.cellCount = cardOnDeckView.count
        
        for i in 0..<cardOnDeckView.count {
            cardOnDeckView[i].frame = grid[i] ?? CGRect.zero
        }
        
        var cardState = CardView.CardState.selected
        if game.selectedCardIndices.count >= 3 {
            if game.isMatched {
                cardState = .matched
            } else {
                cardState = .notmatched
            }
        }
        
        for indexReset in 0..<cardOnDeckView.count {
            cardOnDeckView[indexReset].state = .normal
        }
        
        for indexSelected in game.selectedCardIndices {
            cardOnDeckView[indexSelected].state = cardState
        }
        
        setNeedsLayout()
        setNeedsDisplay()
    }
    
}

