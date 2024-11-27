//
//  GameView.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 11/19/24 at 8:14 PM.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var gameOver = false
    @State private var gameData = GameData()
    @State private var tappedIndex: Int?
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(playerTurn())
                    .font(.title)
                LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                    ForEach(gameData.board.indices, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 200, maxHeight: 200)
                            .overlay {
                                Text(gameData.board[index])
                                    .font(.largeTitle)
                                    .foregroundStyle(Helper.PlayerColor(gameData.board, index))
                            }
                            .scaleEffect(tappedIndex == index ? 1.05 : 1.0)
                            .animation(.spring, value: tappedIndex)
                            .onTapGesture {
                                animateTap(index)
                                gameData.updateBoard(index: index)
                                gameOver = gameData.endGame()
                            }
                    }
                }
                Spacer()
            }
            .padding(10)
            .fontWeight(.black)
            .background(.crewDarkGray)
            .foregroundStyle(.crewOrange)
            .navigationDestination(isPresented: $gameOver) {
                ResultView(gameData)
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    GameView()
}

extension GameView {
    private func animateTap(_ index: Int) {
        guard gameData.board[index] != "X", gameData.board[index] != "O" else { return }
        tappedIndex = index
        Task {
            try await Task.sleep(nanoseconds: 250_000_000)
            tappedIndex = nil
        }
    }
    
    private func playerTurn() -> String {
        guard gameData.turnCount > 0 else {
            return "Player X begins"
        }
        if gameData.turnCount % 2 == 0 {
            return "It's Player X's turn"
        } else {
            return "It's Player O's turn"
        }
    }
}
