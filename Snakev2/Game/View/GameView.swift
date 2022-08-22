//
//  GameView.swift
//  Snakev2
//
//  Created by advanc3d on 21.08.2022.
//

import UIKit

class GameView: UIView {
    
    var pauseButton = ControlButton(image: "pause.circle")

    // used if storyboard or xib used
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
        addAllSubviews()
    }
    
    // used if manual use in loadView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
        addAllSubviews()
    }
    
    private func setup() {
        self.backgroundColor = .green
        self.translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        self.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        addConstraintsForMyButton()
        super.updateConstraints()
    }
    
    private func addConstraintsForMyButton() {
        pauseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pauseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        pauseButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        pauseButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    func addAllSubviews() {
        addSubview(pauseButton)
    }
}
