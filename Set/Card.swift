//
//  Card.swift
//  Set
//
//  Created by Cao Trong Duy Nhan
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import Foundation

struct Card: CustomStringConvertible, Hashable {
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    init(num N: CardNum, shape S: Shape, shading Sd: Shading, color C: CardColor) {
        num = N
        shape = S
        shading = Sd
        color = C
    }
    
    init() {
        num = Card.CardNum.all[0]
        shape = Card.Shape.all[0]
        shading = Card.Shading.all[0]
        color = Card.CardColor.all[0]
    }

    var description: String { return "\(num) \(color) \(shading) \(shape)"}
    
    var num: CardNum
    var shape: Shape
    var shading: Shading
    var color: CardColor
    
    var state = CardView.CardState.normal
    
    var identifier: Int {
        get {
            if let ident = Int("\(num.rawValue)\(shape.rawValue)\(shading.rawValue)\(color.rawValue)") {
                return ident
            } else {
                return 0
            }
        }
    }
    
    enum CardNum: Int, CustomStringConvertible {
        var description: String {
            switch self {
            case .one: return "One"
            case .two: return "Two"
            case .three: return "Three"
            }
        }
        case one = 1
        case two = 2
        case three = 3
        
        static var all = [CardNum.one, .two, .three]
    }
    
    enum Shape: Int, CustomStringConvertible {
        var description: String {return "Shape "+String(rawValue)}
        case shape1
        case shape2
        case shape3
        
        static var all = [Shape.shape1, .shape2, .shape3]
    }
    
    enum Shading: Int, CustomStringConvertible {
        var description: String {
            switch self {
            case .open: return "Open"
            case .striped: return "Striped"
            case .solid: return "Solid"
            }
        }
        case open
        case striped
        case solid
        
        static var all = [Shading.open, .striped, .solid]
    }
    
    enum CardColor: Int, CustomStringConvertible {
        var description: String { return "Color "+String(rawValue)}
        case color1
        case color2
        case color3
        
        static var all = [CardColor.color1, .color2, .color3]
    }
}
