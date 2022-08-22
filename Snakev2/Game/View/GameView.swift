//
//  GameView.swift
//  Snakev2
//
//  Created by advanc3d on 21.08.2022.
//

import UIKit

class GameView: UIView {
    
    var pauseButton = ControlButton(image: "pause.circle")
    var restartButton = ControlButton(image: "repeat")

    // used if storyboard or xib used
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
        addAllSubviews()
    }
    
    // used if manual use in loadView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
        addAllSubviews()
    }
    
    private func setup() {
        self.backgroundColor = .green
        self.translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.setNeedsUpdateConstraints()
    }
    
    func addAllSubviews() {
        addSubview(pauseButton)
        addSubview(restartButton)
    }
    
    //MARK:- Constraints
    override func updateConstraints() {
        addAllConstraints()
        super.updateConstraints()
    }
    
    private func addAllConstraints() {
        pauseButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        pauseButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        pauseButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 56).isActive = true
        pauseButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 17).isActive = true
        
        restartButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        restartButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        restartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -56).isActive = true
        restartButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 17).isActive = true
        
    }
}
