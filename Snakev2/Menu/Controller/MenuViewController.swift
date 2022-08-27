//
//  MenuViewController.swift
//  Snakev2
//
//  Created by advanc3d on 26.08.2022.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var optionsButton: UIButton!

    var speedUpMode: Bool = UserDefaults.standard.bool(forKey: CaseUserDefaults.speedUpMode)
    var classicMode: Bool = UserDefaults.standard.bool(forKey: CaseUserDefaults.classicMode)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupRecordLabel()
        updateModSettings()
    }
    
    private func setupViews() {
        view.backgroundColor = .black
        newGameButton.layer.cornerRadius = 10
        optionsButton.layer.cornerRadius = 10
    }
    
    private func setupRecordLabel() {
        let record = UserDefaults.standard.integer(forKey: CaseUserDefaults.record)
        
        if record == 0 {
            recordLabel.numberOfLines = 1
            recordLabel.text = "no record detected"
        } else {
            recordLabel.numberOfLines = 2
            recordLabel.text = """
                                \(String(record))
                                by \(UserDefaults.standard.string(forKey: CaseUserDefaults.playerName)!)
                                """
        }
    }
    
    private func updateModSettings() {
        speedUpMode = UserDefaults.standard.bool(forKey: CaseUserDefaults.speedUpMode)
        classicMode = UserDefaults.standard.bool(forKey: CaseUserDefaults.classicMode)
        print("speedup: \(speedUpMode), classicmode: \(classicMode)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "options" {
            let optionsVC = segue.destination as! OptionsTableViewController
            optionsVC.speedUpMode = self.speedUpMode
            optionsVC.classicMode = self.classicMode
        }
    }
}

