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
    var moveSnakeDuration = 0.0
    
    var newPiece = Piece()
    var status: GameStatus = .lost {
        willSet {
            if newValue == .lost {
                print("status changed to lost")
            } else {
                print("status changed to started")
            }
        }
    }
    var timer: Timer?
    
    var dX = Piece.width
    var dY = 0
    
    //MARK:- Methods
    func start() {
        dX = Piece.width
        dY = 0
        score = 0
        level = 1
        playerName = "unknown hero"
        timerTimeInterval = 0.3
        moveSnakeDuration = 0.35
        
        newPiece.getNewPosition()
        Snake.createSnake()
        
        startTimer()
        status = .started
        NotificationCenter.default.post(name: .onGameStarted, object: nil)
    }
    
    func changeMovingDirection(senderTag: Int) {
        guard status == .started else { return }
        let currentSnakeDirection = Snake.shared.body[0].direction
        
        switch senderTag {
        case 0 where currentSnakeDirection == .up || currentSnakeDirection == .down: dX = -Piece.width; dY = 0
        case 1 where currentSnakeDirection == .up || currentSnakeDirection == .down: dX = Piece.width; dY = 0
        case 2 where currentSnakeDirection == .left || currentSnakeDirection == .right: dX = 0; dY = -Piece.height
        case 3 where currentSnakeDirection == .left || currentSnakeDirection == .right: dX = 0; dY = Piece.height
        default: return
        }
    }
    
    func finish() {
        status = .lost
        cancelTimer()
        Snake.eraseSnake()
    }
}

