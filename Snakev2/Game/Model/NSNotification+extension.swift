//
//  NSNotification+extension.swift
//  Snakev2
//
//  Created by advanc3d on 23.08.2022.
//

import Foundation

extension NSNotification.Name {
    static var gameStarted: Notification.Name {
        return .init("onGameStarted")
    }
    
    static var gameLost: Notification.Name {
        return NSNotification.Name.init("onGameLost")
    }
    
    static var onSnakeAppend: Notification.Name {
        return .init("onSnakeAppend")
    }
}
