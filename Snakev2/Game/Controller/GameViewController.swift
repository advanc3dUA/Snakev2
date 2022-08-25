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
        gameView.pauseButton.addTarget(self, action: #selector(testClick), for: .touchUpInside)
        for button in gameView.moveButtons {
            button.addTarget(self, action: #selector(clickedMoveButton(sender:)), for: .touchUpInside)
        }
    }
    
    @objc func testClick() {
        print("clicked")
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
    }
    
    //MARK:- Observers
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(addNewPieceToSnake(_:)), name: .onSnakeAppend, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSnakeViewPosition(_:)), name: .onSnakeMove, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateNewPiecePosition(_:)), name: .onPieceGotNewPosition, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(gameFinished), name: .onGameLost, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pickupNewPiece), name: .onPickupNewPiece, object: nil)
    }
    
    @objc private func addNewPieceToSnake(_ notification: Notification) {
        if let x = notification.userInfo?["x"] as? Int, let y = notification.userInfo?["y"] as? Int {
            gameView.snakeView.append(UIImageView(frame: CGRect(x: x, y: y, width: Piece.width, height: Piece.height)))
            gameView.snakeView.last?.backgroundColor = .black
            gameView.gameField.addSubview(gameView.snakeView[0])
        }
    }
    
    @objc private func updateSnakeViewPosition(_ notification: Notification) {
        guard game.status == .started else { return }
        var newCenterX: CGFloat = 0
        var newCenterY: CGFloat = 0
        
        for index in 0..<Snake.shared.body.count {
            newCenterX = CGFloat(Snake.shared.body[index].x + Piece.width / 2)
            newCenterY = CGFloat(Snake.shared.body[index].y + Piece.height / 2)
            gameView.snakeView[index].center.x = newCenterX
            gameView.snakeView[index].center.y = newCenterY
        }
    }
    
    @objc func updateNewPiecePosition(_ notification: Notification) {
        if let x = notification.userInfo?["x"] as? Int, let y = notification.userInfo?["y"] as? Int {
            gameView.newPieceView.center.x = CGFloat(x + Piece.width / 2)
            gameView.newPieceView.center.y = CGFloat(y + Piece.height / 2)
        }
    }
    
    @objc func gameFinished() {
        game.status = .lost
        gameView.eraseViews()
        Snake.eraseSnake()
    }
    
    @objc func pickupNewPiece() {
        gameView.snakeView.append(UIImageView(frame: CGRect(x: game.newPiece.x, y: game.newPiece.y, width: Piece.width, height: Piece.height)))
        gameView.snakeView.last?.backgroundColor = .yellow
        gameView.gameField.addSubview(gameView.snakeView.last!)
        
        game.newPiece.getNewPosition()
        
        game.score += 1
        gameView.scoreLabel.updateScore(with: game.score)
    }
}

