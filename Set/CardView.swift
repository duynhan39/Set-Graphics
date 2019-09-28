//
//  CardView.swift
//  Set
//
//  Created by Cao Trong Duy Nhan on 6/21/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import UIKit

@IBDesignable
class CardView: UIView {

    var card = Card() {
        didSet{setNeedsDisplay()}
    }
    
    var state = CardState.normal
    {
        didSet {setNeedsDisplay()}
    }
    
    enum CardState: String, CustomStringConvertible {
        var description: String {
            return rawValue
        }
        case normal = "normal"
        case selected = "selected"
        case matched = "matched"
        case notmatched = "notmatched"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var bounds: CGRect {
        didSet{
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsLayout()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
    
        let roundedRect = UIBezierPath(roundedRect: cardBounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
        CardView.borderColor[state]?.setStroke()
        roundedRect.lineWidth = cardWidth*SizeRatio.borderToCardWidth
        roundedRect.stroke()
        
        drawShapeOnCard()
    }
    
    var cardColor: UIColor { get{ return CardView.colorSet[card.color] ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) }}
    
    func drawShapeOnCard() {
        for i in 0..<card.num.rawValue {
            let rect = CGRect(x: figureXOffset, y: figureYOffset + CGFloat(i)*cardHeight/3, width: figureWidth, height: figureHeight)
            if let figure = CardView.shapeSet[card.shape] {
                let shape = figure.drawShape(boundedBy: rect)
                
                cardColor.setStroke()
                cardColorShading.setFill()
                shape.lineWidth = cardWidth*SizeRatio.borderToCardWidth
                shape.stroke()
                shape.fill()
            }
        }
    }
    
}

extension CardView {
    struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.025
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
        static let cardWidthToHeigh: CGFloat = 5.0/8.0
        static let fillRatio: CGFloat = 0.9
        static let shapeToCard: CGFloat = 0.7
        static let stripeToCardWidth: CGFloat = 1.0/120.0
        static let borderToCardWidth: CGFloat = 1.8/36.0
    }
    
    var stripeWid: CGFloat {
        get{ return (round(2*cardWidth*SizeRatio.stripeToCardWidth) + 1)/2.0 }
    }
    
    var cardBounds: CGRect {
        return CGRect(x: bounds.width/2 - cardWidth/2, y: bounds.height/2 - cardHeight/2, width: cardWidth, height: cardHeight)
    }
    
    var cardHeight: CGFloat {
        get {
            return CGFloat.minimum(bounds.width/SizeRatio.cardWidthToHeigh, bounds.height)*SizeRatio.fillRatio
        }
    }
    
    var cardWidth: CGFloat {
        get {
            return cardHeight*SizeRatio.cardWidthToHeigh
        }
    }
    
    private var cornerRadius: CGFloat {
        return cardHeight * SizeRatio.cornerRadiusToBoundsHeight
    }
    
    private var cardToFigureOffset: CGFloat {
        return cardWidth*(1.0 - SizeRatio.shapeToCard)
    }
    
    private var figureWidth: CGFloat {
        return cardWidth*SizeRatio.shapeToCard //- cardToFigureOffset
    }
    
    private var figureHeight: CGFloat{
        return cardHeight/3.0*SizeRatio.shapeToCard //- cardToFigureOffset
    }
    
    private var figureXOffset: CGFloat {
        return (cardWidth - figureWidth)/2.0 + cardBounds.minX
    }
    
    private var figureYOffset: CGFloat {
        let offset = (cardHeight/3.0 - figureHeight)/2.0 + cardBounds.minY
        return CGFloat(3.0 - Double(card.num.rawValue))*cardHeight/6.0 + offset
    }
    
    static let colorSet = [Card.CardColor.color1: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),
                           Card.CardColor.color2: #colorLiteral(red: 0.4666666687, green: 0.8266707937, blue: 0.2666666806, alpha: 1),
                           Card.CardColor.color3: #colorLiteral(red: 0.518281864, green: 0.1590199523, blue: 0.9686274529, alpha: 1) ]
    
    static let borderColor = [CardState.normal: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0),
                              CardState.selected: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1),
                              CardState.matched: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1),
                              CardState.notmatched: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)]
    
    static let shapeSet = [Card.Shape.shape1: OvalShape(),
                           Card.Shape.shape2: DiamondShape(),
                           Card.Shape.shape3: SquiggleShape()] as [Card.Shape: FigureOnCard]
    
    var cardColorShading: UIColor {
        get {
            switch self.card.shading {
            case Card.Shading.solid: return cardColor
            case Card.Shading.open: return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case Card.Shading.striped:
                
                let color1 = cardColor
                let color1Width: CGFloat = stripeWid
                let color1Height: CGFloat = 100
                
                let color2 = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                let color2Width: CGFloat = 2*stripeWid
                let color2Height: CGFloat = 100
                
                //// Set pattern tile orientation vertical.
                let patternWidth: CGFloat = (color1Width + color2Width)
                let patternHeight: CGFloat = min(color1Height, color2Height)
                
                //// Set pattern tile size.
                let patternSize = CGSize(width: patternWidth, height: patternHeight)
                
                //// Draw pattern tile
                UIGraphicsBeginImageContextWithOptions(patternSize, false, 0.0)
                
                let color1Path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: color1Width, height: color1Height))
                color1.setFill()
                color1Path.fill()
                
                let color2Path = UIBezierPath(rect: CGRect(x: color1Width, y: 0, width: color2Width, height: color2Height))
                color2.setFill()
                color2Path.fill()
                
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                //// Draw pattern in view
                return UIColor(patternImage: image!)
            }
        }
    }

}
