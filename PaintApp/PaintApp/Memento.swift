//
//  Memento.swift
//  PaintApp
//
//  Created by Aigerim Abdurakhmanova on 30.06.2022.
//

import Foundation
import UIKit

protocol Memento {
    var shapes: [ShapeViewModel] { get }
}

class ConcreteMemento: Memento {
    private(set) var shapes: [ShapeViewModel]
    
    public init(shape: [ShapeViewModel]) {
        self.shapes = shape
    }
}

class Caretaker {
    
    private var states: [Memento] = []
    private var painter: CanvasView
    private var currentIndex: Int = 0
    
    init(painter: CanvasView) {
        self.painter = painter
    }
    
    func save() {
        let tail = states.count - 1 - currentIndex
        if tail > 0 { states.removeLast(tail) }
        
        states.append(painter.save())
        currentIndex = states.count - 1
    }
        
    func undo(steps: Int) {
        guard steps <= currentIndex else { return }

        currentIndex -= steps
        painter.restore(memento: states[currentIndex])
//
//        guard !states.isEmpty else { return }
//        let removedMemento = states.removeLast()
//
//        painter.restore(memento: removedMemento)
    }
    
    func redo(steps: Int) {
        let newIndex = currentIndex + steps
        guard newIndex < states.count - 1 else { return }
        
        currentIndex = newIndex
        painter.restore(memento: states[currentIndex])
    }
}


