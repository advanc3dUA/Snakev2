//
//  FieldImageView.swift
//  Snakev2
//
//  Created by advanc3d on 22.08.2022.
//

import UIKit

class FieldImageView {
    static var shared = FieldImageView()
    let field: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 0,
                                                  height: 0))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.layer.masksToBounds = false
        imageView.layer.borderWidth = CGFloat(pieceSize)
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private init() { }
    
    
}
