//
//  TriangleFactory.swift
//  PaintApp
//
//  Created by Aigerim Abdurakhmanova on 29.06.2022.
//

import UIKit

final class TriangleFactory: ShapeFactory {
    private func angleBetweenPoints(pointA: CGPoint, pointB: CGPoint) -> Double{
        let deltaY = pointB.y - pointA.y
        let deltaX = pointB.x - pointB.y
        return atan2(deltaY, deltaX)
    }
    
    private func thirdPoint(start: CGPoint, end: CGPoint) -> CGPoint {
        let angleBetween = angleBetweenPoints(pointA: start, pointB: end)
        let angleBetweenTwoSides = ((((3 - 2) * 180 / 3) * M_PI / 180))
        let distance = hypot(end.x - start.x, end.y - start.y)
        let x = end.x + (distance * cos(angleBetween + angleBetweenTwoSides))
        let y = end.y + (distance * sin(angleBetween + angleBetweenTwoSides))
        return CGPoint(x: x, y: y)
    }
    
    func create(configuration: ShapeConfiguration) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: configuration.startPoint)
        path.addLine(to: thirdPoint(start: configuration.startPoint, end: configuration.endPoint))
        path.addLine(to: configuration.endPoint)
        path.close()
        
        path.setup(with: configuration.color, lineWidth: configuration.lineWidth, isFilled: configuration.isFileld)
        return path
    }
}
