//
//  LoseLogo.swift
//  Snakev2
//
//  Created by advanc3d on 25.08.2022.
//

import Foundation
import UIKit

class LoseLogo: UIImageView {
        
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.image = UIImage(named: "wasted2")
        self.alpha = 0.0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
