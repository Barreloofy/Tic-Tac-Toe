//  ComputerPlayerLogic.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 12/1/24 at 6:32 PM.
//

func miniMax(_ game: GameData, _ isMaximizer: Bool, _ computerIsPlayerX: Bool) -> (score: Int, index: Int?) {
    var game = game
    if game.endGame() {
        switch game.result {
        case "Player X":
            return computerIsPlayerX ? (1, nil) : (-1, nil)
        case "Player O":
            return computerIsPlayerX ? (-1, nil) : (1, nil)
        default:
            return (0, nil)
        }
    }
    if isMaximizer {
        return minimaxForPlayer(game, isMaximizer: true, computerIsPlayerX)
    } else {
        return minimaxForPlayer(game, isMaximizer: false, computerIsPlayerX)
    }
}

func makeMove(_ game: GameData, at index: Int, with player: String) -> GameData {
    var game = game
    game.board[index] = player
    return game
}

func minimaxForPlayer(_ game: GameData, isMaximizer: Bool, _ computerIsPlayerX: Bool) -> (score: Int, index: Int?) {
    let bestScoreComparison: (Int, Int) -> Bool = isMaximizer ? (>) : (<)
    let currentPlayer: String
    if isMaximizer {
        currentPlayer = computerIsPlayerX ? "X" : "O"
    } else {
        currentPlayer = computerIsPlayerX ? "O" : "X"
    }
    let emptyBoardCells = game.board.enumerated().filter { $0.element == "" }.map { $0.offset }
    if emptyBoardCells.isEmpty {
        return (score: 0, index: nil)
    }
    var bestScore = isMaximizer ? Int.min : Int.max
    var bestMoves = [Int]()
    for emptyCell in emptyBoardCells {
        let updatedGame = makeMove(game, at: emptyCell, with: currentPlayer)
        let (score, _) = miniMax(updatedGame, !isMaximizer, computerIsPlayerX)
        
        if bestScoreComparison(score, bestScore) {
            bestScore = score
            bestMoves = [emptyCell]
        } else if score == bestScore {
            bestMoves.append(emptyCell)
        }
    }
    let randomBestMove = bestMoves.randomElement()
    return (score: bestScore, index: randomBestMove)
}
