//
//  ViewController.swift
//  Snakev2
//
//  Created by advanc3d on 21.08.2022.
//

import UIKit

class GameViewController: UIViewController {
    
    var gameView = GameView()
    let game = Game()
    var alert = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView = view as! GameView
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTargets()
        addObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        game.startNewGame()
    }
    
    //MARK:- Methods
    func addTargets() {
        gameView.pauseButton.addTarget(self, action: #selector(pauseGame), for: .touchUpInside)
        gameView.restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        for button in gameView.moveButtons {
            button.addTarget(self, action: #selector(clickedMoveButton(sender:)), for: .touchUpInside)
        }
    }
    
    @objc func pauseGame() {
        guard let timer = game.timer else { return }
        if timer.isValid {
            
            for button in gameView.moveButtons {
                button.isHidden = true
            }
            timer.invalidate()
            gameView.restartButton.isHidden = true
            gameView.pauseButton.isSelected = true
        } else {
            
            for button in gameView.moveButtons {
                button.isHidden = false
            }
            game.startTimer()
            gameView.restartButton.isHidden = false
            gameView.pauseButton.isSelected = false
        }
    }
    
    @objc func restartGame() {
        gameFinished()
        game.startNewGame()
        gameView.levelLabel.update(with: game.level)
        gameView.scoreLabel.update(with: game.score)
    }
    
    @objc func clickedMoveButton(sender: UIButton) {
        guard game.status == .started else { return }
        let currentSnakeDirection = Snake.shared.body[0].direction
        
        switch sender.tag {
        case 0 where currentSnakeDirection == .up || currentSnakeDirection == .down: game.dX = -Piece.width; game.dY = 0
        case 1 where currentSnakeDirection == .up || currentSnakeDirection == .down: game.dX = Piece.width; game.dY = 0
        case 2 where currentSnakeDirection == .left || currentSnakeDirection == .right: game.dX = 0; game.dY = -Piece.height
        case 3 where currentSnakeDirection == .left || currentSnakeDirection == .right: game.dX = 0; game.dY = Piece.height
        default: return
        }
        
        gameView.feedback.feedbackForMoveButton()
    }
    
    //MARK:- Observers
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(gameStarted(_:)), name: .onGameStarted, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addNewPieceToSnake(_:)), name: .onSnakeAppend, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSnakeViewPosition(_:)), name: .onSnakeMove, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateNewPiecePosition(_:)), name: .onPieceGotNewPosition, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(gameFinished), name: .onGameLost, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(levelUp), name: .onLevelUp, object: nil)
    }
    
    @objc private func gameStarted(_ notification: Notification) {
        game.status = .started
        gameView.loseLogo.alpha = 0.0
        gameView.pauseButton.alpha = 1.0
        for button in gameView.moveButtons {
            button.alpha = 1.0
        }
    }
    
    @objc private func addNewPieceToSnake(_ notification: Notification) {
        if let x = notification.userInfo?["x"] as? Int, let y = notification.userInfo?["y"] as? Int {
            gameView.addNewPieceToSnakeView(x: x, y: y)
        }
        game.newPiece.getNewPosition()
        game.score += 1
        gameView.scoreLabel.update(with: game.score)
    }
    
    @objc private func updateSnakeViewPosition(_ notification: Notification) {
        guard game.status == .started else { return }
        var newCenterX: CGFloat = 0
        var newCenterY: CGFloat = 0
        UIView.animate(withDuration: game.moveSnakeDuration) { [unowned self] in
            for index in 0..<Snake.shared.body.count {
                newCenterX = CGFloat(Snake.shared.body[index].x + Piece.width / 2)
                newCenterY = CGFloat(Snake.shared.body[index].y + Piece.height / 2)
                gameView.snakeView[index].center.x = newCenterX
                gameView.snakeView[index].center.y = newCenterY
            }
        }
    }
    
    @objc func updateNewPiecePosition(_ notification: Notification) {
        if let x = notification.userInfo?["x"] as? Int, let y = notification.userInfo?["y"] as? Int {
            UIView.animate(withDuration: 1) { [unowned self] in
                gameView.newPieceView.center.x = CGFloat(x + Piece.width / 2)
                gameView.newPieceView.center.y = CGFloat(y + Piece.height / 2)
                gameView.gameField.addSubview(gameView.newPieceView)
            }
        }
    }
    
    @objc func gameFinished() {
        game.status = .lost
        game.cancelTimer()
        gameView.loseLogo.alpha = 1.0
        gameView.eraseViews()
        gameView.pauseButton.alpha = 0.0
        for button in gameView.moveButtons {
            button.alpha = 0.0
        }
        Snake.eraseSnake()
        if Record.isNewRecord(game.score) {
            createAlert()
        }
    }
    
    @objc func levelUp() {
        gameView.levelLabel.update(with: game.level)
        gameView.levelLabel.flash(numberOfFlashes: 3)
        for piece in gameView.snakeView {
            piece.flash(numberOfFlashes: 3)
        }
    }
}

