//
//  ViewController.swift
//  PaintApp
//
//  Created by Aigerim Abdurakhmanova on 14.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var canvasView: CanvasView!
    private var colorsArray: [UIColor] = [#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 1, green: 0.4059419876, blue: 0.2455089305, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 1, green: 0.4059419876, blue: 0.2455089305, alpha: 1), #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.3823936913, green: 0.8900789089, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.4528176247, blue: 0.4432695911, alpha: 1), #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)]
        
    @IBOutlet private var undoRemoveButton: UIButton!
    
    @IBOutlet var fillSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillSwitch.isOn = false
        collectionView.delegate = self
        collectionView.dataSource = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(long))
        tapGesture.numberOfTapsRequired = 1
        undoRemoveButton.addGestureRecognizer(tapGesture)
        undoRemoveButton.addGestureRecognizer(longGesture)
    }

    @objc private func tap () {
        canvasView.undoDraw()
    }
    
    @objc private func long() {
        print("Long press")
        canvasView.clearCanvas()
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        if sender.isOn {
            canvasView.filled = true
        } else {
            canvasView.filled = false
        }
    }
    
    @IBAction private func lineButtonPressed(_ sender: UIButton) {
        canvasView.drawMode = .line
    }
    
    @IBAction private func penButtonPressed(_ sender: UIButton) {
        canvasView.drawMode = .pen
    }
    
    @IBAction private func rectangleButtonPressed(_ sender: UIButton) {
        canvasView.drawMode = .rectangle
    }
    
    @IBAction private func triangleButtonPressed(_ sender: UIButton) {
        canvasView.drawMode = .triangle
    }
    @IBAction private func circleButtonPressed(_ sender: UIButton) {
        canvasView.drawMode = .circle
    }
    
    @IBAction func cornerRadius(_ sender: UIButton) {
        canvasView.drawMode = .cornerTriangle
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorsArray.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
           return 1
       }
    
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
       cell.contentView.backgroundColor = colorsArray[indexPath.row]
       return cell
   }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = colorsArray[indexPath.row]
        canvasView.lineColor = color
    }
    
}
