//
//  Game.swift
//  Snakev2
//
//  Created by advanc3d on 23.08.2022.
//

import Foundation

class Game {
    var newPiece = Piece()
    var status: GameStatus = .lost {
        didSet {
            if oldValue == .lost {
                postGameStartedNotification()
            } else {
                postGameLostNotification()
            }
        }
    }
    var timer: Timer?
    var timerTimeInterval = timerTimeIntervalConst
    var moveSnakeDuration = moveSnakeDurationConst
        
    func startNewGame() {
        score = 0
        level = 1
        playerName = ""
        newPiece.getNewPosition()
        Snake.createSnake()
        startTimer(moveTo: .right)
        self.status = .started
    }
    
    func finishGame() {
        
    }
    
    //MARK:- lose game conditions
    func touchedBorders() -> Bool {
        let head = Snake.shared.body[0]
        
        if head.x < 20 && Snake.shared.body[0].direction == .left {
            return true
        }
        if head.x > fieldWidth - 2 * pieceSize && Snake.shared.body[0].direction == .right {
            return true
        }
        if head.y < 20 && Snake.shared.body[0].direction == .up {
            return true
        }
        if head.y > fieldHeight - 2 * pieceSize && Snake.shared.body[0].direction == .down {
            return true
        }
        return false
    }
    
    func tailIsTouched() -> Bool {
        guard Snake.shared.body.count > 1 else { return false }
        for index in stride(from: 1, to: Snake.shared.body.count, by: 1) {
            if Snake.shared.body[0].x == Snake.shared.body[index].x && Snake.shared.body[0].y == Snake.shared.body[index].y {
                return true
            }
        }
        return false
    }
    
    private func postGameStartedNotification() {
        print("status changed to started")
        NotificationCenter.default.post(name: .gameStarted, object: nil)
    }
    
    private func postGameLostNotification() {
        print("status changed to lost")
        NotificationCenter.default.post(name: .gameLost, object: nil)
    }
}

