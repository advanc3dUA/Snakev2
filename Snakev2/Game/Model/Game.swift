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
    
    private func postGameStartedNotification() {
        print("status changed to started")
        NotificationCenter.default.post(name: .onGameStarted, object: nil)
    }
    
    private func postGameLostNotification() {
        print("status changed to lost")
        NotificationCenter.default.post(name: .onGameLost, object: nil)
    }
}

