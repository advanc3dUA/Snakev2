//
//  FieldImageView.swift
//  Snakev2
//
//  Created by advanc3d on 27.08.2022.
//

import UIKit

@IBDesignable
class FieldImageView: UIImageView {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.masksToBounds = false
        self.layer.borderWidth = CGFloat(Piece.width)
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 5
    }
    //Doesn't work. Why?
    override func draw(_ rect: CGRect) {
        print("draw started")
        let pathRect = CGRect(x: 40, y: 40, width: rect.width - 50, height: rect.height - 50)
        let path = UIBezierPath(roundedRect: pathRect, cornerRadius: 5)
        let color = UIColor.red
        color.setFill()
        path.fill()
        print("draw finished")
    }

}
