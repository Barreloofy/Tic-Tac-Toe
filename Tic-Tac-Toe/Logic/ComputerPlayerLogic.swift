//
//  ComputerPlayerLogic.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 12/1/24 at 6:32 PM.
//

func miniMax(_ game: GameData, _ isMaximizer: Bool) -> (score: Int, index: Int?) {
    var newGame = game
    if newGame.endGame() {
        switch newGame.result {
        case "Player X": return (1, nil)
        case "Player O": return (-1, nil)
        default: return (0, nil)
        }
    }
    if isMaximizer {
        return minimaxForPlayer(newGame, isMaximizer: true)
    } else {
        return minimaxForPlayer(newGame, isMaximizer: false)
    }
}

func makeMove(_ game: GameData, at index: Int, with player: String) -> GameData {
    var newGame = game
    newGame.board[index] = player
    return newGame
}

func minimaxForPlayer(_ game: GameData, isMaximizer: Bool) -> (score: Int, index: Int?) {
    let bestScoreComparison: (Int, Int) -> Bool = isMaximizer ? (>) : (<)
    let currentPlayer = isMaximizer ? "X" : "O"
    let emptyBoardCells = game.board.enumerated().filter { $0.element == "" }.map { $0.offset }
    if emptyBoardCells.isEmpty {
        return (score: 0, index: nil)
    }
    var bestScore = isMaximizer ? Int.min : Int.max
    var bestMove: Int?
    for emptyCell in emptyBoardCells {
        let updatedGame = makeMove(game, at: emptyCell, with: currentPlayer)
        let (score, _) = miniMax(updatedGame, !isMaximizer)
        
        if bestScoreComparison(score, bestScore) {
            bestScore = score
            bestMove = emptyCell
        }
    }
    return (score: bestScore, index: bestMove)
}
