//
//  ResultView.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 11/21/24 at 8:15 PM.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var playAgain = false
    @State private var wasPressedPlayAgain = false
    @State private var wasPressedHome = false
    let gameData: GameData
    init(_ gameData: GameData) {
        self.gameData = gameData
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Helper.DrawBoard(gameData.board)
                Text(gameData.result != nil ? "\(gameData.result!) won" : "It's a Draw!")
                    .rotationEffect(Angle(degrees: 5))
                    .underline()
                    .padding(.top, 50)
                Text("Play Again!")
                    .rotationEffect(Angle(degrees: -5))
                    .opacity(wasPressedPlayAgain ? 0.5 : 1.0)
                    .buttonAnimation(wasPressed: $wasPressedPlayAgain) { playAgain = true }
                    .padding(.top, 50)
                Text("Home")
                    .rotationEffect(Angle(degrees: 5))
                    .opacity(wasPressedHome ? 0.5 : 1.0)
                    .buttonAnimation(wasPressed: $wasPressedHome) { dismiss() }
                    .padding(.top, 50)
                Spacer()
            }
            .font(.largeTitle)
            .fontWeight(.black)
            .background(.crewDarkGray)
            .foregroundStyle(.crewOrange)
            .navigationDestination(isPresented: $playAgain) {
                GameView()
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    ResultView(GameData())
}
