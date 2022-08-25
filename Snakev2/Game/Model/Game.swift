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
    var timerTimeInterval = 0.3
    var moveSnakeDuration = 0.4
    
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
        
    func startNewGame() {
        dX = Piece.width
        dY = 0
        score = 0
        level = 1
        playerName = "unknown hero"
        timerTimeInterval = 0.3
        moveSnakeDuration = 0.4
        newPiece.getNewPosition()
        Snake.createSnake()
        startTimer()
        NotificationCenter.default.post(name: .onGameStarted, object: nil)
    }
}

