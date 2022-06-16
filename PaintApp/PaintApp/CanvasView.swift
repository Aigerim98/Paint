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

struct Line {
    let color: UIColor
    var points: [(CGPoint, CGPoint)]
    var drawMode: DrawMode
}

class CanvasView: UIView {
    
    var lineColor: UIColor = .black
    var lineWidth: CGFloat = 10
    var drawMode: DrawMode = .pen
    
    private var lines: [Line] = []
    private var path: UIBezierPath!
    private var touchPoint: CGPoint!
    private var startingPoint: CGPoint!
    private var lastPoint: CGPoint = CGPoint(x: 0, y: 0)
   // private var shapeLayer: CAShapeLayer!
    
//    override func layoutSubviews() {
//        self.clipsToBounds = true
//        self.isMultipleTouchEnabled = false
//        lineWidth = 15
//    }
    
    override func draw(_ rect: CGRect) {
        
        lines.forEach{ line in
            line.color.setStroke()
            line.points.forEach{ start, end in
                path = UIBezierPath()
                switch line.drawMode {
                case .pen:
                    drawPen(start: start, last: end)
                    break
                case .line:
                    drawLine(from: start, to: end)
                    break
                case .rectangle:
                    drawRectangle(start: start, end: end)
                    break
                case .circle:
                    drawCircle(start: start, end: end)
                case .triangle:
                    drawTriangleSecond(start: start, end: end)
                }
                
                path.lineWidth = lineWidth
                path.stroke()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let start = touches.first?.location(in: self) else { return }
        lines.append(Line(color: lineColor, points: [(start, lastPoint)], drawMode: drawMode))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: self) else { return }
        
        guard var last = lines.popLast() else { return }
        guard var lastPoint = last.points.popLast() else { return }
        
        lastPoint.1 = touchPoint
        last.points.append(lastPoint)
        
        if drawMode == .pen {
            last.points.append((touchPoint, touchPoint))
        }
        
        lines.append(last)
        setNeedsDisplay()
    }
    
    private func drawPen(start: CGPoint, last: CGPoint) {
        path.move(to: start)
        path.addLine(to: last)
        
    }
    
    private func drawLine(from start: CGPoint, to end: CGPoint){
        path.move(to: start)
        path.addLine(to: end)
    }
    
    private func drawRectangle(start: CGPoint, end: CGPoint){
        let width = end.x - start.x
        let height = end.y - start.y
        let rectanglePath = UIBezierPath(rect: CGRect(x: start.x, y: start.y, width: width, height: height))
        path = rectanglePath
    }
    
    private func drawTriangle(start: CGPoint, end: CGPoint) {
        let corner = CGPoint(x: start.x, y: end.y)
        path.move(to: start)
        path.addLine(to: corner)
        path.addLine(to: end)
        path.close()
    }
    
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
    
    private func drawTriangleSecond(start: CGPoint, end: CGPoint) {
        path.move(to: start)
        path.addLine(to: thirdPoint(start: start, end: end))
        path.addLine(to: end)
        path.close()
    }
    
    private func drawCircle(start: CGPoint, end: CGPoint) {
        let radius = end.x - start.x
        let circlePath = UIBezierPath(ovalIn: CGRect(x: start.x, y: start.y, width: radius, height: radius))
        path = circlePath
    }
}
