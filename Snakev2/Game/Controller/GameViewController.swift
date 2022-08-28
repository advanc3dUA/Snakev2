//
//  ViewController.swift
//  Snakev2
//
//  Created by advanc3d on 21.08.2022.
//

import UIKit

let fieldWidth = 300
let fieldHeight = 400

class GameViewController: UIViewController {
    
    var speedUpMode: Bool?
    var classicMode: Bool?
    lazy var game = Game(speedUpMode: speedUpMode!, classicMode: classicMode!)
    var alert = UIAlertController()
    override func loadView() {
        self.view = GameView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        game.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        finishGame()
    }
    
    //MARK:- Methods
    func view() -> GameView {
        return view as! GameView
    }
    
    func addTargets() {
        view().pauseButton.addTarget(self, action: #selector(pauseGame), for: .touchUpInside)
        view().restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        for button in view().moveButtons {
            button.addTarget(self, action: #selector(onMoveButtonClick(sender:)), for: .touchUpInside)
        }
    }
    
    @objc func pauseGame() {
        guard let timer = game.timer else { return }
        if timer.isValid {
            
            for button in view().moveButtons {
                button.isHidden = true
            }
            timer.invalidate()
            view().restartButton.isHidden = true
            view().pauseButton.isSelected = true
        } else {
            
            for button in view().moveButtons {
                button.isHidden = false
            }
            game.startTimer()
            view().restartButton.isHidden = false
            view().pauseButton.isSelected = false
        }
    }
    
    @objc func restartGame() {
        finishGame()
        game.start()
        view().levelLabel.update(with: game.level)
        view().scoreLabel.update(with: game.score)
    }
    
    @objc func onMoveButtonClick(sender: UIButton) {
        game.changeMovingDirection(sender.tag)
    }
    
    //MARK:- Observers
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(gameStarted(_:)), name: .onGameStarted, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addNewPieceToSnake(_:)), name: .onSnakeAppend, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSnakeViewPosition(_:)), name: .onSnakeMove, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateNewPiecePosition(_:)), name: .onPieceGotNewPosition, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(finishGameAndSaveRecord), name: .onGameLost, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(levelUp), name: .onLevelUp, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(feedback), name: .onSuccessfulSnakeTurn, object: nil)
    }
    
    @objc private func gameStarted(_ notification: Notification) {
        view().loseLogo.alpha = 0.0
        view().pauseButton.alpha = 1.0
        for button in view().moveButtons {
            button.alpha = 1.0
        }
        view().levelLabel.update(with: game.level)
    }
    
    @objc private func addNewPieceToSnake(_ notification: Notification) {
        if let x = notification.userInfo?["x"] as? Int, let y = notification.userInfo?["y"] as? Int {
            view().addNewPieceToSnakeView(x: x, y: y)
            
            if classicMode == true {
                view().snakeView.last?.backgroundColor = .black
            }
        }
        view().scoreLabel.update(with: game.score)
    }
    
    @objc private func updateSnakeViewPosition(_ notification: Notification) {
        guard game.status == .started else { return }
        var newCenterX: CGFloat = 0
        var newCenterY: CGFloat = 0
        UIView.animate(withDuration: game.moveSnakeDuration) { [unowned self] in
            for index in 0..<Snake.shared.body.count {
                newCenterX = CGFloat(Snake.shared.body[index].x + Piece.width / 2)
                newCenterY = CGFloat(Snake.shared.body[index].y + Piece.height / 2)
                view().snakeView[index].center.x = newCenterX
                view().snakeView[index].center.y = newCenterY
            }
            if classicMode == false {
                view().rotateHead()
                view().rotateBody()
                view().rotateTale()
                
            }
        }
    }
    
    @objc func updateNewPiecePosition(_ notification: Notification) {
        if let x = notification.userInfo?["x"] as? Int, let y = notification.userInfo?["y"] as? Int {
            if classicMode == true {
                view().newPieceView.backgroundColor = .red
            } else {
                view().newPieceView.image = SnakeImagesDict.shared["apple"]
            }
            UIView.animate(withDuration: 1) { [unowned self] in
                view().newPieceView.center.x = CGFloat(x + Piece.width / 2)
                view().newPieceView.center.y = CGFloat(y + Piece.height / 2)
                view().gameField.addSubview(view().newPieceView)
            }
        }
    }
    private func finishGame() {
        game.finish()
        
        view().loseLogo.alpha = 1.0
        view().eraseViews()
        view().pauseButton.alpha = 0.0
        for button in view().moveButtons {
            button.alpha = 0.0
        }
    }
    
    @objc func finishGameAndSaveRecord() {
        finishGame()
        if Record.isNewRecord(game.score) {
            createAlert()
        }
    }
    
    @objc func levelUp() {
        view().levelLabel.update(with: game.level)
        view().levelLabel.flash(numberOfFlashes: 3)
        for piece in view().snakeView {
            piece.flash(numberOfFlashes: 3)
        }
    }
    
    @objc func feedback() {
        view().feedback.feedbackForMoveButton()
    }
}

