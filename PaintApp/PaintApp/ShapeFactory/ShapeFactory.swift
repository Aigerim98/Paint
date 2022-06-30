//
//  ShapeFactory.swift
//  PaintApp
//
//  Created by Aigerim Abdurakhmanova on 29.06.2022.
//

import Foundation
import UIKit

protocol ShapeFactory {
    func create(configuration: ShapeConfiguration) -> UIBezierPath
}

extension UIBezierPath {
    func setup(with color: UIColor, lineWidth: CGFloat, isFilled: Bool) {
        color.setStroke()
        if isFilled {
            color.setFill()
            fill()
        }
        
        self.lineWidth = lineWidth
    }
}
