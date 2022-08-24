//
//  NSNotification+extension.swift
//  Snakev2
//
//  Created by advanc3d on 23.08.2022.
//

import Foundation

extension NSNotification.Name {
    static var onGameStarted: Notification.Name {
        return .init("onGameStarted")
    }
    
    static var onGameLost: Notification.Name {
        return NSNotification.Name.init("onGameLost")
    }
    
    static var onSnakeAppend: Notification.Name {
        return .init("onSnakeAppend")
    }
    
    static var onSnakeMove: Notification.Name {
        return .init("onSnakeMove")
    }
    
    static var onPieceGotNewPosition: Notification.Name {
        return .init("onPieceGotNewPosition")
    }
    
    static var onPickupNewPiece: Notification.Name {
        return .init("onPickupNewPiece")
    }
    
    static var onLevelUp: Notification.Name {
        return self.init("onLevelUp")
    }
}
