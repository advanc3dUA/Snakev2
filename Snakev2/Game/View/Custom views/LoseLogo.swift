//
//  LoseLogo.swift
//  Snakev2
//
//  Created by advanc3d on 25.08.2022.
//

import Foundation
import UIKit

class LoseLogo: UIImageView {
        
    init(_ x: CGFloat, _ y: CGFloat) {
        super.init(frame: CGRect(x: x,
                                 y: y,
                                 width: CGFloat(FieldImageView.height / 2),
                                 height: CGFloat(FieldImageView.height / 2)))
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.image = UIImage(named: "wasted2")
    }
}
