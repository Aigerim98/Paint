//
//  CanvasView.swift
//  PaintApp
//
//  Created by Aigerim Abdurakhmanova on 14.06.2022.
//

import UIKit


enum DrawMode {
    case pen
    case line
    case rectangle
    case circle
    case triangle
}

class CanvasView: UIView {
    
    var lineColor: UIColor = .black
    var lineWidth: CGFloat!
    var drawMode: DrawMode = .pen
    
    private var path: UIBezierPath!
    private var touchPoint: CGPoint!
    private var startingPoint: CGPoint!
    private var lastPoint: CGPoint!
    
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.isMultipleTouchEnabled = false
        lineWidth = 5
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        startingPoint = touch?.location(in: self)
        print("Start \(startingPoint)")
        guard let lastPosition = self.lastPoint else{ return}
        self.lastPoint = startingPoint
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        touchPoint = touch?.location(in: self)
        drawShapeLayer(startPoint: startingPoint, lastPoint: touchPoint)
        self.lastPoint = touchPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let lastPoint = self.lastPoint else {return}
        print(lastPoint)
        touchPoint = touch.location(in: self)
        //drawShapeLayer(startPoint: touchPoint, lastPoint: lastPoint)
        self.lastPoint = touchPoint
    }
    
    func drawShapeLayer(startPoint: CGPoint, lastPoint: CGPoint) {
        switch (drawMode) {
        case .pen:
            //print("End \(lastPoint)")
            drawPen(start: startPoint, last: lastPoint)
            break
        case .line:
            drawLine(start: startPoint, toPoint: lastPoint)
            break
        case .rectangle:
            print("rectangle")
            break
        case .circle:
            print("circle")
            break
        case .triangle:
            print("triangle")
            break
        }
        self.setNeedsDisplay()
    }
    
    func drawPen(start: CGPoint, last: CGPoint) {
        print("pen")
        let shapeLayer = CAShapeLayer()
        path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: last)
        
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth =  lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        startingPoint = touchPoint
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func drawLine(start: CGPoint, toPoint end: CGPoint){
        print("line")
        path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        self.layer.addSublayer(shapeLayer)
    }
    
}
