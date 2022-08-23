//
//  Game.swift
//  Snakev2
//
//  Created by advanc3d on 23.08.2022.
//

import Foundation

class Game {
    var status: GameStatus = .lost {
        didSet {
            if oldValue == .lost {
                print("status changed to started")
                postGameStartedNotification()
            } else {
                print("status changed to lost")
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
        newPiece = PieceOfSnake().createNewPieceOfSnake()
        snake.createSnake()
        startTimer(moveTo: .right)
        self.status = .started
    }
    
    func finishGame() {
        
    }
    
    //MARK:- lose game conditions
    func touchedBorders() -> Bool {
        let head = snake.body[0]
        
        if head.x < 20 && snake.body[0].direction == .left {
            return true
        }
        if head.x > fieldWidth - 2 * PieceOfSnake.width && snake.body[0].direction == .right {
            return true
        }
        if head.y < 20 && snake.body[0].direction == .up {
            return true
        }
        if head.y > fieldHeight - 2 * PieceOfSnake.height && snake.body[0].direction == .down {
            return true
        }
        return false
    }
    
    func tailIsTouched() -> Bool {
        guard snake.body.count > 1 else { return false }
        for index in stride(from: 1, to: snake.body.count, by: 1) {
            if snake.body[0].x == snake.body[index].x && snake.body[0].y == snake.body[index].y {
                return true
            }
        }
        return false
    }
    
    private func postGameStartedNotification() {
        NotificationCenter.default.post(name: .gameStarted, object: nil)
    }
    
    private func postGameLostNotification() {
        NotificationCenter.default.post(name: .gameLost, object: nil)
    }
}

extension NSNotification.Name {
    static var gameStarted: Notification.Name {
        return .init("gameStarted")
    }
    
    static var gameLost: Notification.Name {
        return NSNotification.Name.init("gameLost")
    }
}
