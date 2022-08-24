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
        willSet {
            if newValue == .lost {
                print("status changed to lost")
            } else {
                print("status changed to started")
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
}

