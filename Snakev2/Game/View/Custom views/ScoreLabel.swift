//
//  LevelLabel.swift
//  Snakev2
//
//  Created by advanc3d on 22.08.2022.
//

import UIKit

class ScoreLabel: UILabel {
    var scoreText = "Score: "
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.text = scoreText + String(score)
        self.defaultSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func defaultSetup() {
        self.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        self.backgroundColor = .lightGray
        self.font = UIFont.boldSystemFont(ofSize: 20)
        self.textColor = .systemBlue
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
