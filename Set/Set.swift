//
//  Set.swift
//  Set
//
//  Created by Cao Trong Duy Nhan
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import Foundation

class Set {
    var cardsOnStack = [Card]()
    var deck = [Card?]()
    var selectedCardIndices = [Int]()
    private(set) var isMatched = false
    
    init() {
        for num in Card.CardNum.all {
            for color in Card.CardColor.all {
                for shape in Card.Shape.all {
                    for shading in Card.Shading.all {
                        cardsOnStack.append(Card(num: num, shape: shape, shading: shading, color: color))
                    }
                }
            }
        }
        cardsOnStack = cardsOnStack.shuffled()
        
        for _ in 0..<12 {
            if cardsOnStack.count <= 0 { break }
            deck.append(cardsOnStack.remove(at: 0))
        }
    }
    
    func chooseCard(at index: Int) {
        assert(deck.indices.contains(index), "Set.chooseCard(at: \(index)) :index out of range")
        
        if selectedCardIndices.count < 3
        {
            if selectedCardIndices.contains(index) {
                selectedCardIndices.removeAll(where: {$0 == index})
            } else {
                selectedCardIndices.append(index)
            }
            if selectedCardIndices.count == 3 {
                isMatched = checkMatch()
            }
        } else {
            if isMatched {
                selectedCardIndices = selectedCardIndices.sorted().reversed()
                replaceMatchedCard()
            }
            let toBeAdded: Bool = (selectedCardIndices.contains(index) && !isMatched)
            selectedCardIndices.removeAll()
            if toBeAdded {
                selectedCardIndices.append(index)
            }
            isMatched = false
        }
    }
    
    func checkMatch() -> Bool {
        var total = 0
        for index in selectedCardIndices {
            if let card = deck[index] {
                total += card.identifier
            }
        }
        
        for digit in String(total) {
            if Int(String(digit))! % 3 != 0 {return false}
        }
        
        return true
    }
    
    private func replaceMatchedCard() {
        for index in selectedCardIndices.indices {
            if cardsOnStack.count > 0 {
                deck[selectedCardIndices[index]] = cardsOnStack.remove(at: 0)
            } else {
                deck.remove(at: selectedCardIndices[index])
            }
        }
    }
}

extension Int {    
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(-self)))
        } else {
            return 0
        }
    }
}
