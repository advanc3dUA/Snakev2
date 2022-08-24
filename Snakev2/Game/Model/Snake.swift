//
//  Snake.swift
//  Snakev2
//
//  Created by advanc3d on 23.08.2022.
//

import Foundation

class Snake {
    var body: [Piece] = []
    static var shared = Snake()
    
    private init() { }
    
    //MARK:- game methods
    static func createSnake() {
        let snakeHead = Piece(x: pieceSize, y: pieceSize)
        Snake.shared.body.append(snakeHead)
        NotificationCenter.default.post(name: .onSnakeAppend, object: nil, userInfo: ["x": snakeHead.x, "y": snakeHead.y])
    }
    
    static func eraseSnake() {
        Snake.shared.body.removeAll()
    }
        
    //MARK:- add or pickup new piece methods
    static func pickUpNewPiece(_ newPiece: Piece) -> Bool {
        if Snake.shared.body[0].x == newPiece.x && Snake.shared.body[0].y == newPiece.y {
            Snake.shared.body.append(newPiece)
            score += 1
            return true
        }
        return false
    }
    
    //MARK:- moving methods
    static func saveLastPositions() {
        for index in 0..<Snake.shared.body.count {
            Snake.shared.body[index].saveLastPosition()
        }
    }
    static func moveSnake(_ dX: Int, _ dY: Int) {
        Snake.shared.body[0].x += dX
        Snake.shared.body[0].y += dY
        
        for index in 1..<Snake.shared.body.count {
            Snake.shared.body[index].x = Snake.shared.body[index - 1].lastX ?? 0
            Snake.shared.body[index].y = Snake.shared.body[index - 1].lastY ?? 0
        }
    }
    
    //MARK:- checking current direction
    static func checkDirection() -> Direction {
        let head = Snake.shared.body[0]
        if let lastX = head.lastX, let lastY = head.lastY {
            if (head.x - lastX) > 0 { return .right }
            if (head.x - lastX) < 0 { return .left }
            if (head.y - lastY) > 0 { return .down }
        }
        return .up
    }
}
