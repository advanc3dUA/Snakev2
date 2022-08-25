//
//  Record.swift
//  Snakev2
//
//  Created by advanc3d on 25.08.2022.
//

import Foundation

class Record {
    
    static func isNewRecord(_ score: Int) -> Bool {
        if score > UserDefaults.standard.integer(forKey: CaseUserDefaults.record) {
            return true
        }
        return false
    }
    static func saveRecord(_ score: Int) {
        UserDefaults.standard.setValue(score, forKey: CaseUserDefaults.record)
    }
    
    static func savePlayerName(_ playerName: String) {
        UserDefaults.standard.setValue(playerName, forKey: CaseUserDefaults.playerName)
    }
}
