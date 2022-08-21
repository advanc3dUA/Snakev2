//
//  GameView.swift
//  Snakev2
//
//  Created by advanc3d on 21.08.2022.
//

import UIKit

class GameView: UIView {

    // used if storyboard or xib used
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .green
        setupButton()
    }
    
    // used if manual use in loadView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        setupButton()
    }
    
    func setupButton() {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        button.backgroundColor = .black
        addSubview(button)
    }
    
}
