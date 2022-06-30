//
//  CanvasView.swift
//  PaintApp
//
//  Created by Aigerim Abdurakhmanova on 14.06.2022.
//

import UIKit

class CanvasView: UIView {
    lazy var caretaker = Caretaker(originator: self)
    var lineColor: UIColor = .black
    var lineWidth: CGFloat = 5
    var drawMode: ShapeType = .pen
    var filled: Bool = false
    private var shapes: [ShapeViewModel] = []
    private var path: UIBezierPath!
    private var touchPoint: CGPoint!
    private var startingPoint: CGPoint!
    private var lastPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    func save() -> Memento {
        return ConcreteMemento(shape: shapes[shapes.count - 1])
    }
    
    func restore(memento: Memento) {
        guard let memento = memento as? ConcreteMemento else { return }
        //self.shapes = memento.shapes
        shapes.append(memento.shapes)
    }
    
    override func draw(_ rect: CGRect) {
        shapes.forEach{ shape in
            shape.color.setStroke()
            shape.points.forEach{ start, end in
                let factory = shape.type.factory
                let configuration = ShapeConfiguration(startPoint: start, endPoint: end, isFileld: shape.filled, color: shape.color)
                path = factory.create(configuration: configuration)
                caretaker.backup()
                path.stroke()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let start = touches.first?.location(in: self) else { return }
        let viewModel = ShapeViewModel(color: lineColor, points: [(start, lastPoint)], type: drawMode, filled: filled)
        shapes.append(viewModel)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: self) else { return }
        
        guard var last = shapes.popLast() else { return }
        guard var lastPoint = last.points.popLast() else { return }
        
        lastPoint.toPoint = touchPoint
        last.points.append(lastPoint)
        
        if drawMode == .pen {
            last.points.append((touchPoint, touchPoint))
        }
        shapes.append(last)
        
        setNeedsDisplay()
    }
    
    func undoDraw() {
//        if shapes.count > 0 {
//            shapes.removeLast()
//            setNeedsDisplay()
//        }
        caretaker.undo()
        setNeedsDisplay()
    }
    
    func clearCanvas() {
        shapes.removeAll()
        setNeedsDisplay()
    }
    
    
}
