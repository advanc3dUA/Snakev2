//
//  PieceOfSnake.swift
//  Snakev2
//
//  Created by advanc3d on 23.08.2022.
//

import Foundation

struct Piece {
    var x: Int {
        didSet {
            if (x - oldValue) > 0 { direction = .right }
            if (x - oldValue) < 0 { direction = .left }
        }
    }
    var y: Int {
        didSet {
            if (y - oldValue) > 0 { direction = .down }
            if (y - oldValue) < 0 { direction = .up }
        }
    }
    var lastX: Int?
    var lastY: Int?
    
    var direction: Direction?
    
    init(x: Int = 0, y: Int = 0) {
        self.x = x
        self.y = y
    }
    
    
    //MARK:- new piece of snake methods
    func getRandomXY() -> (x: Int, y: Int) {
        var randomX = 0, randomY = 0
        repeat {
            repeat {
                randomX = Int.random(in: (pieceSize / 10)...fieldWidth / 10 - 4) * 10
            } while randomX % pieceSize != 0
            
            repeat {
                randomY = Int.random(in: (pieceSize / 10)...fieldHeight / 10 - 4) * 10
            } while randomY % pieceSize != 0
            
        } while checkPointIsInSnakeBody(x: randomX, y: randomY)
        
        return (randomX, randomY)
    }
    
    func checkPointIsInSnakeBody(x: Int, y: Int) -> Bool {
        for piece in Snake.shared.body {
            if piece.x == x && piece.y == y {
                return true
            }
        }
        return false
    }
    
    mutating func getNewPosition() -> () {
        let randomFieldPoint = getRandomXY()
        self.x = randomFieldPoint.x
        self.y = randomFieldPoint.y
        NotificationCenter.default.post(name: .onPieceGotNewPosition, object: nil, userInfo: ["x": self.x, "y": self.y])
    }
    
    mutating func saveLastPosition() {
        self.lastX = self.x
        self.lastY = self.y
    }
}
