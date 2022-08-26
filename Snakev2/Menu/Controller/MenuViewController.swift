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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupRecordLabel()
        
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
}

