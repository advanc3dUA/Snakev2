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
}

