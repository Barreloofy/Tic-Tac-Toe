//
//  GameView.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 11/19/24 at 8:14 PM.
//

import SwiftUI
import AVFoundation

struct GameView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var gameData = GameData()
    @State private var gameOver = false
    @State private var tappedIndex: Int?
    @State private var tapButtonSE: AVAudioPlayer?
    private var buttonSoundEffectURL: URL?
    init() {
        buttonSoundEffectURL = try? Helper.configureSound(&tapButtonSE, "notification-beep", "mp3")
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.crewDarkGray
                    .ignoresSafeArea()
                VStack {
                    Text(playerTurn())
                        .font(.title)
                        .rotationEffect(Angle(degrees: -2.5))
                    ZStack {
                        Grid()
                            .stroke(.crewPurple, lineWidth: 5)
                        DrawBoard()
                    }
                    .frame(width: 350, height: 350)
                    Spacer()
                }
                .padding(10)
                .fontWeight(.black)
                .foregroundStyle(.crewOrange)
                .shadow(color: .gray, radius: 8, x: 5, y: -5)
                .navigationDestination(isPresented: $gameOver) {
                    ResultView(gameData)
                        .navigationBarBackButtonHidden()
                }
                .onDisappear {
                    tapButtonSE?.stop()
                }
            }
        }
    }
}

private extension GameView {
    
    func DrawBoard() -> some View {
        return LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
            ForEach(gameData.board.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .fill(.crewDarkGray)
                    .aspectRatio(contentMode: .fit)
                    .padding(10)
                    .overlay {
                        Text(gameData.board[index])
                            .font(.largeTitle)
                            .foregroundStyle(Helper.PlayerColor(gameData.board, index))
                    }
                    .scaleEffect(tappedIndex == index ? 1.05 : 1.0)
                    .animation(.spring, value: tappedIndex)
                    .onTapGesture {
                        handleTap(index: index)
                    }
            }
        }
    }
    
    func animateTap(_ index: Int) {
        guard gameData.board[index] != "X", gameData.board[index] != "O" else { return }
        tappedIndex = index
        Task {
            try await Task.sleep(nanoseconds: 250_000_000)
            tappedIndex = nil
        }
    }
    
    func playButtonSound() {
        guard let url = buttonSoundEffectURL else { return }
        tapButtonSE = try? AVAudioPlayer(contentsOf: url)
        tapButtonSE?.play()
    }
    
    func playerTurn() -> String {
        guard gameData.turnCount > 0 else {
            return "Player X begins"
        }
        if gameData.turnCount % 2 == 0 {
            return "It's Player X's turn"
        } else {
            return "It's Player O's turn"
        }
    }
    
    func handleTap(index: Int) {
        Task {
            async let buttonSound: () = playButtonSound()
            async let buttonTap: () = animateTap(index)
            
            await buttonSound
            await buttonTap
            gameData.updateBoard(index: index)
            gameOver = gameData.endGame()
        }
    }
}

#Preview {
    GameView()
}
