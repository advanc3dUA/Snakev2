//
//  Game+Timer.swift
//  Snakev2
//
//  Created by advanc3d on 23.08.2022.
//

import Foundation

extension Game {
    
    func startTimer(moveTo: Direction) {
        timer = Timer.scheduledTimer(withTimeInterval: timerTimeInterval, repeats: true, block: { [unowned self] (Timer) in
            var dX = 0
            var dY = 0
            
            switch moveTo {
            case .left: dX -= 20
            case .right: dX += 20
            case .up: dY -= 20
            case .down: dY += 20
            }
            
            Snake.moveSnake(dX, dY)
            
            if Snake.touchedBorders() || Snake.tailIsTouched() {
                NotificationCenter.default.post(name: .onGameLost, object: nil)
                cancelTimer()
            }
            //            if snake.pickUpNewPiece(newPiece) {
            //                pickupNewPiece(newPieceView)
            //            }
            
            NotificationCenter.default.post(name: .onSnakeMove, object: nil)
        })
        
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func speedUp() {
        timerTimeInterval *= 0.95
        moveSnakeDuration *= 0.95
    }
}
