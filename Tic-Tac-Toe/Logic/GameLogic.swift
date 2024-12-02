//
//  GameLogic.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 11/19/24 at 9:21 PM.
//

struct GameData {
    var turnCount = 0
    var board = Array(repeating: "", count: 9)
    var result: String?
    
    mutating func updateBoard(index: Int) {
        guard board[index] == "" else { return }
        if turnCount % 2 == 0 {
            board[index] = "X"
        } else {
            board[index] = "O"
        }
        turnCount += 1
    }
    
    mutating func endGame() -> Bool {
        return checkRow() || checkColumn() || checkDiagonal() || turnCount == 9
    }
    
    private mutating func checkRow() -> Bool {
        for key in [0,3,6] {
            guard board[key] != "" else { continue }
            if board[key] == board[key + 1] && board[key] == board[key + 2] {
                result = board[key] == "X" ? "Player X" : "Player O"
                return true
            }
        }
        return false
    }

    private mutating func checkColumn() -> Bool {
        for key in [0,1,2] {
            guard board[key] != "" else { continue }
            if board[key] == board[key + 3] && board[key] == board[key + 6] {
                result = board[key] == "X" ? "Player X" : "Player O"
                return true
            }
        }
        return false
    }

    private mutating func checkDiagonal() -> Bool {
        if board[0] != "" {
            if board[0] == board[4] && board[0] == board[8] {
                result = board[0] == "X" ? "Player X" : "Player O"
                return true
            }
        }
        if board[2] != "" {
            if board[2] == board[4] && board[2] == board[6] {
                result = board[2] == "X" ? "Player X" : "Player O"
                return true
            }
        }
        return false
    }
}
