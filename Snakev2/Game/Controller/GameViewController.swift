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
    let snake = Snake()
    
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
    
    private func updateUI() {
        for piece in gameView.snakeView {
            
        }
    }
    
    // observers
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(addNewPieceToSnake(_:)), name: .onSnakeAppend, object: nil)
    }
    
    @objc private func addNewPieceToSnake(_ notification: Notification) {
        if let x = notification.userInfo?["x"] as? Int, let y = notification.userInfo?["y"] as? Int {
            gameView.snakeView.append(UIImageView(frame: CGRect(x: x, y: y, width: pieceWidth, height: pieceWidth)))
            gameView.snakeView[0].backgroundColor = .black
            gameView.gameField.addSubview(gameView.snakeView[0])
        }
    }
}

