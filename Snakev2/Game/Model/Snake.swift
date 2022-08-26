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
        let snakeHead = Piece(x: Piece.width, y: Piece.height)
        Snake.shared.body.append(snakeHead)
        NotificationCenter.default.post(name: .onSnakeAppend, object: nil, userInfo: ["x": Snake.shared.body.last?.x as Any, "y": Snake.shared.body.last?.y as Any])
    }
    
    static func eraseSnake() {
        Snake.shared.body.removeAll()
    }
        
    //MARK:- pickup new piece methods
    static func isReadyToPickUp(_ newPiece: Piece) -> Bool {
        if Snake.shared.body[0].x == newPiece.x && Snake.shared.body[0].y == newPiece.y { return true }
        else { return false }
    }
    
    static func pickUpNewPiece(_ newPiece: Piece) {
        Snake.shared.body.append(newPiece)
    }
    
    //MARK:- moving methods
    static func saveLastPositions() {
        for index in 0..<Snake.shared.body.count {
            Snake.shared.body[index].saveLastPosition()
        }
    }
    
    static func moveSnake(_ dX: Int, _ dY: Int) {
        Snake.saveLastPositions()
        Snake.shared.body[0].x += dX
        Snake.shared.body[0].y += dY
        
        for index in 1..<Snake.shared.body.count {
            Snake.shared.body[index].x = Snake.shared.body[index - 1].lastX ?? 0
            Snake.shared.body[index].y = Snake.shared.body[index - 1].lastY ?? 0
        }
        Snake.shared.body[0].direction = Snake.checkDirection()
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
    
    //MARK:- lose game conditions
    static func touchedBorders() -> Bool {
        let head = Snake.shared.body[0]
        
        if head.x < 20 && Snake.shared.body[0].direction == .left {
            return true
        }
        if head.x > FieldImageView.width - 2 * Piece.width && Snake.shared.body[0].direction == .right {
            return true
        }
        if head.y < 20 && Snake.shared.body[0].direction == .up {
            return true
        }
        if head.y > FieldImageView.height - 2 * Piece.height && Snake.shared.body[0].direction == .down {
            return true
        }
        return false
    }
    
    static func tailIsTouched() -> Bool {
        guard Snake.shared.body.count > 1 else { return false }
        for index in stride(from: 1, to: Snake.shared.body.count, by: 1) {
            if Snake.shared.body[0].x == Snake.shared.body[index].x && Snake.shared.body[0].y == Snake.shared.body[index].y {
                return true
            }
        }
        return false
    }
}
