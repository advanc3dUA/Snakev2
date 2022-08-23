//
//  SnakeImage.swift
//  Snakev2
//
//  Created by advanc3d on 23.08.2022.
//

import UIKit

class SnakeView {
    var body = [UIImageView]()
    
    init(head: CGRect) {
        let frame = CGRect(x: head.maxX, y: head.maxX, width: head.width, height: head.height)
        let head = UIImageView(frame: frame)
        head.backgroundColor = .black
        body.append(head)
    }
}
