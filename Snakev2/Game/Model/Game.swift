//
//  Game.swift
//  Snakev2
//
//  Created by advanc3d on 23.08.2022.
//

import Foundation

class Game {
    var score = 0
    var level = 1
    var playerName = ""
    var timerTimeInterval = 0.0
    var updatePiecePositionDuration = 0.0
    
    var newPiece = Piece()
    var status: GameStatus = .lost
    var timer: Timer?
    
    var dX = Piece.width
    var dY = 0
    
    var speedUpMode: Bool
    var classicMode: Bool
    
    //MARK: - Init
    init(speedUpMode: Bool, classicMode: Bool) {
        self.speedUpMode = speedUpMode
        self.classicMode = classicMode
    }
    
    //MARK: - Methods
    func start() {
        dX = Piece.width
        dY = 0
        score = 0
        level = 1
        playerName = "unknown hero"
        timerTimeInterval = 0.3
        updatePiecePositionDuration = 0.35
        
        newPiece.getNewPosition()
        Snake.createSnake()
        
        startTimer()
        status = .started
        NotificationCenter.default.post(name: .onGameStarted, object: nil)
    }
    
    func changeMovingDirection(_ senderTag: Int) {
        guard status == .started else { return }
        let headDirection = Snake.shared.body[0].direction
        switch senderTag {
        case 0 where headDirection == .up || headDirection == .down: dX = -Piece.width; dY = 0; feedbackRequest()
        case 1 where headDirection == .up || headDirection == .down: dX = Piece.width; dY = 0; feedbackRequest()
        case 2 where headDirection == .left || headDirection == .right: dX = 0; dY = -Piece.height; feedbackRequest()
        case 3 where headDirection == .left || headDirection == .right: dX = 0; dY = Piece.height; feedbackRequest()
        default: return
        }
    }
    
    func finish() {
        status = .lost
        cancelTimer()
        Snake.eraseSnake()
    }
    
    private func feedbackRequest() {
        NotificationCenter.default.post(name: .onSuccessfulSnakeTurn, object: nil)
    }
}

