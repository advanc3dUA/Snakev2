//
//  FieldImageView.swift
//  Snakev2
//
//  Created by advanc3d on 27.08.2022.
//

import UIKit

class FieldImageView: UIImageView {
    
    static let width = 300
    static let height = 400
    
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
        self.layer.borderColor = UIColor.lightGray.cgColor
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
