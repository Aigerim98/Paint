//
//  Shape.swift
//  PaintApp
//
//  Created by Aigerim Abdurakhmanova on 29.06.2022.
//

import Foundation
import UIKit

enum ShapeType {
    case pen
    case line
    case rectangle
    case circle
    case triangle
    case cornerTriangle
    
    var factory: ShapeFactory {
        switch self {
        case .line:
            return LineFactory()
        case .pen:
            return LineFactory()
        case .circle:
            return CircleFactory()
        case .triangle:
            return TriangleFactory()
        case .cornerTriangle:
            return CornerTriangleFactory()
        case .rectangle:
            return RectangleFactory()
        }
    }
}

struct ShapeViewModel {
    let color: UIColor
    var points: [(fromPoint: CGPoint, toPoint: CGPoint)]
    var type: ShapeType
    var filled: Bool
}

struct ShapeConfiguration {
    let startPoint: CGPoint
    let endPoint: CGPoint
    let isFileld: Bool
    let lineWidth: CGFloat = 2.0
    let color: UIColor
}
