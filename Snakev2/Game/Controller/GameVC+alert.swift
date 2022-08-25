//
//  GameVC+alert.swift
//  Snakev2
//
//  Created by advanc3d on 25.08.2022.
//

import Foundation
import UIKit

extension GameViewController {
    
    func createAlert() {
        alert = UIAlertController(title: "Congratulations", message: "You've beaten the record!", preferredStyle: .alert)
        alert.addTextField { (textField : UITextField!) in
            textField.placeholder = "Enter your name"
            textField.delegate = self
        }
        
        // save button
        let save = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: {[unowned self] saveAction -> Void in
            let textField = self.alert.textFields![0] as UITextField

            guard let name = textField.text else { return }
            
            if name == "" {
                Record.savePlayerName(game.playerName)
            } else {
                Record.savePlayerName(name)
            }
            
            Record.saveRecord(game.score)
        })
        alert.addAction(save)
        self.present(alert, animated: true, completion: nil)
    }
}

extension GameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
