//
//  CustomLabel.swift
//  Snakev2
//
//  Created by advanc3d on 28.08.2022.
//

import Foundation

import UIKit

class CustomLabel: UILabel {
    var defaultText: String
    
    init(defaultText: String) {
        self.defaultText = defaultText
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        self.defaultText = "defaultText"
        super.init(coder: coder)
    }
    
    private func setup() {
        self.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        self.backgroundColor = .darkGray
        self.font = UIFont.boldSystemFont(ofSize: 20)
        self.textColor = .systemGreen
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func update(with newValue: Int) {
        self.text = defaultText + String(newValue)
    }
}
