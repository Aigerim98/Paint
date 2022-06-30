//
//  TraingleFactory.swift
//  PaintApp
//
//  Created by Aigerim Abdurakhmanova on 29.06.2022.
//

import UIKit

final class CornerTriangleFactory: ShapeFactory {
    func create(configuration: ShapeConfiguration) -> UIBezierPath {
        let path = UIBezierPath()
        let corner = CGPoint(x: configuration.startPoint.x, y: configuration.endPoint.y)
        path.move(to: configuration.startPoint)
        path.addLine(to: corner)
        path.addLine(to: configuration.endPoint)
        path.close()
        
        path.setup(with: configuration.color, lineWidth: configuration.lineWidth, isFilled: configuration.isFileld)
        return path
    }
}
