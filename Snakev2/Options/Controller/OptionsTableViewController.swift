//
//  OptionsTableViewController.swift
//  Snakev2
//
//  Created by advanc3d on 27.08.2022.
//

import UIKit

class OptionsTableViewController: UITableViewController {
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var speedUpSwitch: UISwitch!
    @IBOutlet weak var classicModeSwitch: UISwitch!
    var speedUpMode: Bool!
    var classicMode: Bool!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupResetButton()
        loadSettings()
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
        UserDefaults.standard.setValue(0, forKey: CaseUserDefaults.record)
    }
    @IBAction func speedUpToggle(_ sender: UISwitch) {
        if speedUpSwitch.isOn {
            UserDefaults.standard.setValue(true, forKey: CaseUserDefaults.speedUpMode)
        } else {
            UserDefaults.standard.setValue(false, forKey: CaseUserDefaults.speedUpMode)
        }
    }
    @IBAction func classicModeToggle(_ sender: UISwitch) {
        if classicModeSwitch.isOn {
            UserDefaults.standard.setValue(true, forKey: CaseUserDefaults.classicMode)
        } else {
            UserDefaults.standard.setValue(false, forKey: CaseUserDefaults.classicMode)
        }
    }
    
    func setupResetButton() {
        resetButton.layer.cornerRadius = 5
    }
    
    func loadSettings() {
        if speedUpMode {
            speedUpSwitch.setOn(true, animated: true)
        } else {
            speedUpSwitch.setOn(false, animated: true)
        }
        if classicMode {
            classicModeSwitch.setOn(true, animated: true)
        } else {
            classicModeSwitch.setOn(false, animated: true)
        }
    }
}
