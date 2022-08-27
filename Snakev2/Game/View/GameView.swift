//
//  GameView.swift
//  Snakev2
//
//  Created by advanc3d on 21.08.2022.
//

import UIKit

class GameView: UIView {
    
    //MARK:- Variables
    let gameField = FieldImageView()
    var pauseButton = CustomButton(image: "pause.circle", changesColorOnSelection: true)
    var restartButton = CustomButton(image: "repeat")
    var levelLabel = LevelLabel()
    var scoreLabel = ScoreLabel()
    var moveButtons: [CustomButton] = {
        var array = [CustomButton]()
        //let arrayOfImages = ["arrow.backward", "arrow.forward", "arrow.up", "arrow.down"]
        let arrayOfImages = ["arrowtriangle.left", "arrowtriangle.right", "arrowtriangle.up", "arrowtriangle.down"]
        for index in 0...3 {
            let button = CustomButton(image: arrayOfImages[index])
            button.tag = index
            array.append(button)
        }
        return array
    }()
    var snakeView = [UIImageView]()
    var newPieceView: UIImageView = {
        let piece = UIImageView(frame: CGRect(x: 0, y: 0, width: Piece.width, height: Piece.height))
        return piece
    }()
    var loseLogo = LoseLogo()
    let feedback = Feedback()

    //MARK:- Inits
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
    
    //MARK:- Methods
    private func setup() {
        self.backgroundColor = .black
        self.translatesAutoresizingMaskIntoConstraints = true
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
        addSubview(loseLogo)
    }
    
    func eraseViews() {
        for view in snakeView {
            view.alpha = 0
            view.removeFromSuperview()
        }
        snakeView.removeAll()
        
        newPieceView.removeFromSuperview()
    }
    
    func addNewPieceToSnakeView(x: Int, y: Int) {
        self.snakeView.append(UIImageView(frame: CGRect(x: x, y: y, width: Piece.width, height: Piece.height)))
        self.gameField.addSubview(self.snakeView.last!)
        self.feedback.feedbackForPickUp()
    }
    
    //MARK:- Rotating
    func rotateHead() {
        
        guard let headDirection = Snake.shared.body[0].direction else { return }
        switch headDirection {
        case .right: transition(indexOfImageView: 0, to: "head_right")
        case .left: transition(indexOfImageView: 0, to: "head_left")
        case .up: transition(indexOfImageView: 0, to: "head_up")
        case .down: transition(indexOfImageView: 0, to: "head_down")
        }
    }
    

    func rotateBody() {
        guard Snake.shared.body.count > 2 else { return }
        for index in 1...Snake.shared.body.endIndex - 2 {
            guard let bodyPartDirection = Snake.shared.body[index].direction else { return }
            switch (bodyPartDirection) {
            case .left: transition(indexOfImageView: index, to: "body_horizontal")
            case .right: transition(indexOfImageView: index, to: "body_horizontal")
            case .up: transition(indexOfImageView: index, to: "body_vertical")
            case .down: transition(indexOfImageView: index, to: "body_vertical")
            }
        }
    }

    func rotateTale() {
        guard snakeView.count > 1 else { return }
        guard let taleIndex = snakeView.lastIndex(of: snakeView.last!) else { return }
        guard let taleDirection = Snake.shared.body[taleIndex].direction else { return }
        switch taleDirection {
        case .left: transition(indexOfImageView: taleIndex, to: "tail_right")
        case .right: transition(indexOfImageView: taleIndex, to: "tail_left")
        case .down: transition(indexOfImageView: taleIndex, to: "tail_up")
        case .up: transition(indexOfImageView: taleIndex, to: "tail_down")
        }
    }
    
    func transition(indexOfImageView: Int, to imageName: String) {
        UIView.transition(with: snakeView[indexOfImageView],
                          duration: 0.1,
                          options: [.beginFromCurrentState, .curveEaseOut]) {
            self.snakeView[indexOfImageView].image = SnakeImagesDict.shared[imageName]
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
            pauseButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            pauseButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 17*2),
            
            restartButton.widthAnchor.constraint(equalToConstant: 45),
            restartButton.heightAnchor.constraint(equalToConstant: 45),
            restartButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            restartButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 17*2),
            
            levelLabel.widthAnchor.constraint(equalToConstant: 108),
            levelLabel.heightAnchor.constraint(equalToConstant: 21),
            levelLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 17*2),
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
            moveButtons[3].bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            moveButtons[3].centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            moveButtons[2].widthAnchor.constraint(equalToConstant: 160),
            moveButtons[2].heightAnchor.constraint(equalToConstant: 60),
            moveButtons[2].bottomAnchor.constraint(equalTo: moveButtons[3].topAnchor, constant: -15),
            moveButtons[2].centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            moveButtons[0].widthAnchor.constraint(equalToConstant: 70),
            moveButtons[0].heightAnchor.constraint(equalToConstant: 135),
            moveButtons[0].bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            moveButtons[0].rightAnchor.constraint(equalTo: moveButtons[3].leftAnchor, constant: -15),
            
            moveButtons[1].widthAnchor.constraint(equalToConstant: 70),
            moveButtons[1].heightAnchor.constraint(equalToConstant: 135),
            moveButtons[1].bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            moveButtons[1].leftAnchor.constraint(equalTo: moveButtons[3].rightAnchor, constant: 15),
            
            loseLogo.widthAnchor.constraint(equalToConstant: 277),
            loseLogo.heightAnchor.constraint(equalToConstant: 270),
            loseLogo.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -5),
            loseLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
