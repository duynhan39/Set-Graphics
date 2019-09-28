//
//  FigureOnCard.swift
//  Set
//
//  Created by Cao Trong Duy Nhan on 6/23/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import Foundation
import UIKit

protocol FigureOnCard {
    func drawShape(boundedBy rect: CGRect) -> UIBezierPath
}

class OvalShape: FigureOnCard {
    func drawShape(boundedBy rect: CGRect) -> UIBezierPath {
        return UIBezierPath(ovalIn: rect)
    }
}

class DiamondShape: FigureOnCard {
    func drawShape(boundedBy rect: CGRect) -> UIBezierPath {
        let diamondShape = UIBezierPath()
        diamondShape.move(to: CGPoint(x: rect.midX, y: rect.minY))
        diamondShape.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        diamondShape.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        diamondShape.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        diamondShape.close()
        
        return diamondShape
    }
}

class SquiggleShape: FigureOnCard {
    func drawShape(boundedBy rect: CGRect) -> UIBezierPath {
        let squigglesShape = UIBezierPath()

        squigglesShape.move(to: CGPoint(x: rect.minX + rect.width*ShapeRatio.smallCurveToEdge, y: rect.minY))
        
        squigglesShape.addCurve(
            to: CGPoint(x: rect.maxX - rect.width*ShapeRatio.smallCurveToEdge, y: rect.minY),
            controlPoint1: CGPoint(x: rect.minX + 2*rect.width*ShapeRatio.smallCurveToEdge, y: rect.minY + rect.height*ShapeRatio.curveControlHeightToHeight),
            controlPoint2: CGPoint(x: rect.minX + 2.5*rect.width*ShapeRatio.smallCurveToEdge, y: rect.minY + rect.height*ShapeRatio.curveControlHeightToHeight))
        
        squigglesShape.addCurve(
            to: CGPoint(x: rect.maxX - rect.width*ShapeRatio.smallCurveToEdge, y: rect.maxY),
            controlPoint1: CGPoint(x: rect.maxX - rect.width*ShapeRatio.smallCurveToEdge + rect.height*ShapeRatio.curveControlWidthToHeight,
                                   y: rect.minY + rect.height*ShapeRatio.curveControlWidthToHeight),
            controlPoint2: CGPoint(x: rect.maxX - rect.width*ShapeRatio.smallCurveToEdge + rect.height*ShapeRatio.curveControlWidthToHeight,
                                   y: rect.minY + 2*rect.height*ShapeRatio.curveControlWidthToHeight)
            )
        
        squigglesShape.addCurve(
            to: CGPoint(x: rect.minX + rect.width*ShapeRatio.smallCurveToEdge, y: rect.maxY),
            controlPoint1: CGPoint(x: rect.maxX - 2*rect.width*ShapeRatio.smallCurveToEdge, y: rect.maxY - rect.height*ShapeRatio.curveControlHeightToHeight),
            controlPoint2: CGPoint(x: rect.maxX - 2.5*rect.width*ShapeRatio.smallCurveToEdge, y: rect.maxY - rect.height*ShapeRatio.curveControlHeightToHeight))
        
        squigglesShape.addCurve(
            to: CGPoint(x: rect.minX + rect.width*ShapeRatio.smallCurveToEdge, y: rect.minY),
            controlPoint1: CGPoint(x: rect.minX + rect.width*ShapeRatio.smallCurveToEdge - rect.height*ShapeRatio.curveControlWidthToHeight,
                                   y: rect.maxY - rect.height*ShapeRatio.curveControlWidthToHeight),
            controlPoint2: CGPoint(x: rect.minX + rect.width*ShapeRatio.smallCurveToEdge - rect.height*ShapeRatio.curveControlWidthToHeight,
                                   y: rect.maxY - 2*rect.height*ShapeRatio.curveControlWidthToHeight)
        )
        squigglesShape.close()
        
        return squigglesShape
    }
}

extension SquiggleShape {
    private struct ShapeRatio {
        static let smallCurveToEdge: CGFloat = 0.1
        static let curveControlHeightToHeight: CGFloat = 0.3
        static let curveControlWidthToHeight: CGFloat = 0.19
    }
}
