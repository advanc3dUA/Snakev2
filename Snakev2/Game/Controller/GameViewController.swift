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
    
    func addTargets() {
        gameView.pauseButton.addTarget(self, action: #selector(testClick), for: .touchUpInside)
    }
    
    @objc func testClick() {
        print("clicked")
    }
    
    // adding observers & observer's methods
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(addNewPieceToSnake(_:)), name: .onSnakeAppend, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSnakeViewPosition(_:)), name: .onSnakeMove, object: nil)
    }
    
    @objc private func addNewPieceToSnake(_ notification: Notification) {
        if let x = notification.userInfo?["x"] as? Int, let y = notification.userInfo?["y"] as? Int {
            gameView.snakeView.append(UIImageView(frame: CGRect(x: x, y: y, width: pieceSize, height: pieceSize)))
            gameView.snakeView[0].backgroundColor = .black
            gameView.gameField.addSubview(gameView.snakeView[0])
        }
    }
    
    @objc private func updateSnakeViewPosition(_ notification: Notification) {
        var newCenterX: CGFloat = 0
        var newCenterY: CGFloat = 0
        for index in 0..<Snake.shared.body.count {
            newCenterX = CGFloat(Snake.shared.body[index].x + pieceSize / 2)
            newCenterY = CGFloat(Snake.shared.body[index].y + pieceSize / 2)
            gameView.snakeView[index].center.x = newCenterX
            gameView.snakeView[index].center.y = newCenterY
        }
    }
}

