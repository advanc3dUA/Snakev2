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
            
            currentdX = dX
            currentdY = dY
            
            moveSnake(dX, dY)
            //print(snake.body[0].x, snake.body[0].y)
            
            
            //            if Game.touchedBorders() || Game.tailIsTouched() {
            //                finishGame()
            //            }
            //
            //            if snake.pickUpNewPiece(newPiece) {
            //                pickupNewPiece(newPieceView)
            //            }
            
        })
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    private func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func speedUp() {
        timerTimeInterval *= 0.95
        moveSnakeDuration *= 0.95
    }
    
    private func moveSnake(_ dX: Int, _ dY: Int) {
        
        snake.saveLastPositions()
        snake.moveSnake(dX, dY)
        snake.body[0].direction = snake.checkDirection()
    }
    
}
