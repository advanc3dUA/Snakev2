//
//  GameView.swift
//  Snakev2
//
//  Created by advanc3d on 21.08.2022.
//

import UIKit

class GameView: UIView {
    
    let gameField = FieldImageView.shared.field
    var pauseButton = CustomButton(image: "pause.circle", changesColorOnSelection: true)
    var restartButton = CustomButton(image: "repeat")
    var levelLabel = LevelLabel()
    var scoreLabel = ScoreLabel()
    var moveButtons: [CustomButton] = {
        var array = [CustomButton]()
        let arrayOfImages = ["arrow.backward", "arrow.forward", "arrow.up", "arrow.down"]
        for index in 0...3 {
            let button = CustomButton(image: arrayOfImages[index])
            button.tag = index
            array.append(button)
        }
        return array
    }()
    var snakeView = [UIImageView]()

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
        addSubview(gameField)
        
        for button in moveButtons {
            addSubview(button)
        }
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
            scoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            gameField.widthAnchor.constraint(equalToConstant: CGFloat(fieldWidth)),
            gameField.heightAnchor.constraint(equalToConstant: CGFloat(fieldHeight)),
            gameField.topAnchor.constraint(equalTo: self.scoreLabel.bottomAnchor, constant: 30),
            gameField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            moveButtons[3].widthAnchor.constraint(equalToConstant: 160),
            moveButtons[3].heightAnchor.constraint(equalToConstant: 60),
            moveButtons[3].bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            moveButtons[3].centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            moveButtons[2].widthAnchor.constraint(equalToConstant: 160),
            moveButtons[2].heightAnchor.constraint(equalToConstant: 60),
            moveButtons[2].bottomAnchor.constraint(equalTo: moveButtons[3].topAnchor, constant: -15),
            moveButtons[2].centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            moveButtons[0].widthAnchor.constraint(equalToConstant: 70),
            moveButtons[0].heightAnchor.constraint(equalToConstant: 135),
            moveButtons[0].bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            moveButtons[0].rightAnchor.constraint(equalTo: moveButtons[3].leftAnchor, constant: -15),
            
            moveButtons[1].widthAnchor.constraint(equalToConstant: 70),
            moveButtons[1].heightAnchor.constraint(equalToConstant: 135),
            moveButtons[1].bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            moveButtons[1].leftAnchor.constraint(equalTo: moveButtons[3].rightAnchor, constant: 15)
        ])
    }
}
