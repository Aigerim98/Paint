//
//  Memento.swift
//  PaintApp
//
//  Created by Aigerim Abdurakhmanova on 30.06.2022.
//

import Foundation
import UIKit

protocol Memento {
    var shapes: ShapeViewModel { get }
}

class ConcreteMemento: Memento {
    private(set) var shapes: ShapeViewModel
    
    public init(shape: ShapeViewModel) {
        self.shapes = shape
    }
}

class Caretaker {
    
    private var memento = [Memento] ()
    private var originator: CanvasView
    
    init(originator: CanvasView) {
        self.originator = originator
    }
    
    func backup() {
        memento.append(originator.save())
    }
    
    func undo() {
        guard !memento.isEmpty else { return }
//        print(memento)
        let removedMemento = memento.removeLast()
        print("Restoring state to: \(removedMemento.shapes)")
        originator.restore(memento: removedMemento)
    }
   
}


