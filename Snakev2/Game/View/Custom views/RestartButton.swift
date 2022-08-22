//
//  ControlButton.swift
//  Snakev2
//
//  Created by advanc3d on 22.08.2022.
//

import UIKit

class RestartButton: UIButton {
    var image = UIImage()
    init(image: String, changesColorOnTouch: Bool = false) {
        super.init(frame: .zero)
        guard let imageToSet = UIImage(systemName: image) else { print("wrong button image name"); return }
        self.image = imageToSet
        defaultSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func defaultSetup() {
        self.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        self.backgroundColor = .lightGray
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        self.setImage(image, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
