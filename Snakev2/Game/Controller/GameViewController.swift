//
//  ViewController.swift
//  Snakev2
//
//  Created by advanc3d on 21.08.2022.
//

import UIKit

class GameViewController: UIViewController {

    var gameView = GameView()
    
//    override func loadView() {
//        view = GameView()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView = view as! GameView
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addTargets()
    }
    
    func addTargets() {
        gameView.pauseButton.addTarget(self, action: #selector(testClick), for: .touchUpInside)
    }
    
    @objc func testClick() {
        print("clicked")
    }
}

