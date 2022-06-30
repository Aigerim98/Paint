//
//  CircleFactory.swift
//  PaintApp
//
//  Created by Aigerim Abdurakhmanova on 29.06.2022.
//

import UIKit

final class CircleFactory: ShapeFactory {
    func create(configuration: ShapeConfiguration) -> UIBezierPath {
        let radius = configuration.endPoint.x - configuration.startPoint.x
        
        let rect = CGRect(x: configuration.startPoint.x,
                          y: configuration.startPoint.y,
                          width: radius,
                          height: radius)
        
        let path = UIBezierPath(ovalIn: rect)
        
        path.setup(with: configuration.color,
                   lineWidth: configuration.lineWidth,
                   isFilled: configuration.isFileld)
        return path
    }
}
