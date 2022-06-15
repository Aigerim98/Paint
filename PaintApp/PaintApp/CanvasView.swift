//
//  CanvasView.swift
//  PaintApp
//
//  Created by Aigerim Abdurakhmanova on 14.06.2022.
//

import UIKit

struct TouchPointsAndColor {
    var color: UIColor?
    //var width: CGFloat?
    var points: [CGPoint]?
    
    init(color: UIColor, points: [CGPoint]?){
        self.color = color
        self.points = points
    }
}

enum DrawMode {
    case pen
    case line
    case rectangle
    case circle
    case triangle
}

class CanvasView: UIView {
    
//    var lines = [TouchPointsAndColor]()
//    var strokeColor: UIColor = .black
//    var lastPoint = CGPoint.zero
//    var drawLine: Bool = false
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//
//        lines.forEach{ (line) in
//            for (i, p) in (line.points?.enumerated())! {
//                if i == 0 {
//                    context.move(to: p)
//                } else {
//                    context.addLine(to: p)
//                }
//                context.setStrokeColor(line.color?.withAlphaComponent(1.0).cgColor ?? UIColor.black.cgColor)
//                context.setLineWidth(5.0)
//            }
//            context.setLineCap(.round)
//            context.strokePath()
//        }
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        lines.append(TouchPointsAndColor(color: UIColor(), points: [CGPoint]()))
//        guard let touch = touches.first else { return }
//        lastPoint = touch.location(in: nil)
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first?.location(in: nil) else { return }
//
//        guard var lastPoint = lines.popLast() else {return}
//        lastPoint.points?.append(touch)
//        lastPoint.color = strokeColor
//        lines.append(lastPoint)
//        setNeedsDisplay()
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if drawLine{
//            drawLineFromPoint(start: lastPoint, toPoint: lastPoint, ofColor: strokeColor)
//        }
//    }
//    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor) {
//
//        let path = UIBezierPath()
//        path.move(to: start)
//        path.addLine(to: end)
//
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = path.cgPath
//        shapeLayer.strokeColor = strokeColor.cgColor
//        shapeLayer.lineWidth = 1.0
//
//
//    }
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
       // self.lastPoint = touchPoint
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
