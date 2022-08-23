//
//  Global Variables.swift
//  Snakev2
//
//  Created by advanc3d on 22.08.2022.
//

import Foundation

let pieceWidth = 20
let fieldWidth = 300
let fieldHeight = 400
var score = 0
var level = 1
var playerName = ""

var currentdX: Int = 0
var currentdY: Int = 0

let timerTimeIntervalConst = 0.3
let moveSnakeDurationConst = 0.4

var snake = Snake()
var newPiece = PieceOfSnake()
