//
//  GameView.swift
//  Snakev2
//
//  Created by advanc3d on 21.08.2022.
//

import UIKit

class GameView: UIView {
    
    var pauseButton = PauseButton(image: "pause.circle")
    var restartButton = RestartButton(image: "repeat")
    var levelLabel = LevelLabel()
    var scoreLabel = ScoreLabel()

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
        addSubview(levelLabel)
        addSubview(scoreLabel)
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
        pauseButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 17*2).isActive = true
        
        restartButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        restartButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        restartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -56).isActive = true
        restartButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 17*2).isActive = true
        
        levelLabel.widthAnchor.constraint(equalToConstant: 108).isActive = true
        levelLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        levelLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 17*2).isActive = true
        levelLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        scoreLabel.widthAnchor.constraint(equalToConstant: 108).isActive = true
        scoreLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: self.levelLabel.bottomAnchor, constant: 3).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
}
