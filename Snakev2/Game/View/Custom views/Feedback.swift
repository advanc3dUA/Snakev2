//
//  Feedback.swift
//  Snakev2
//
//  Created by advanc3d on 25.08.2022.
//

import Foundation
import UIKit

class Feedback {
    let moveButtonGenerator = UISelectionFeedbackGenerator()
    let pickUpGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    func feedbackForMoveButton() {
        moveButtonGenerator.selectionChanged()
    }
    
    func feedbackForPickUp() {
        pickUpGenerator.impactOccurred()
    }
}
