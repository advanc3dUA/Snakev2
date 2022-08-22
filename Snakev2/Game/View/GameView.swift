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
    
    var constraintsArray = [NSLayoutConstraint]()

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
        self.backgroundColor = .black
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
        NSLayoutConstraint.activate([
            pauseButton.widthAnchor.constraint(equalToConstant: 45),
            pauseButton.heightAnchor.constraint(equalToConstant: 45),
            pauseButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 56),
            pauseButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 17*2),
            
            restartButton.widthAnchor.constraint(equalToConstant: 45),
            restartButton.heightAnchor.constraint(equalToConstant: 45),
            restartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -56),
            restartButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 17*2),
            
            levelLabel.widthAnchor.constraint(equalToConstant: 108),
            levelLabel.heightAnchor.constraint(equalToConstant: 21),
            levelLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 17*2),
            levelLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            scoreLabel.widthAnchor.constraint(equalToConstant: 108),
            scoreLabel.heightAnchor.constraint(equalToConstant: 21),
            scoreLabel.topAnchor.constraint(equalTo: self.levelLabel.bottomAnchor, constant: 3),
            scoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
    }
}
