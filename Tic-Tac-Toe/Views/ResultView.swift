//
//  ResultView.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 11/21/24 at 8:15 PM.
//

import SwiftUI
import AVFoundation

struct ResultView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var playAgain = false
    @State private var wasPressedPlayAgain = false
    @State private var wasPressedHome = false
    @State private var resultSoundEffect: AVAudioPlayer?
    @State private var buttonSoundEffect: AVAudioPlayer?
    private let buttonSoundEffectURL: URL?
    private let gameData: GameData
    private let vsComputer: Bool
    private let computerIsPlayerX: Bool
    
    init(_ gameData: GameData, _ vsComputer: Bool, _ computerIsPlayerX: Bool) {
        self.gameData = gameData
        self.vsComputer = vsComputer
        self.computerIsPlayerX = computerIsPlayerX
        (self.buttonSoundEffect, self.buttonSoundEffectURL) = try! configureSound("pop-1", "mp3")
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                #if os(iOS)
                Color(.crewDarkGray).ignoresSafeArea()
                #endif
                VStack {
                    GeometryReader { geometry in
                        let sizeLimit = min(geometry.size.width, geometry.size.height) * 0.8
                        Grid(.crewPurple, 4)
                            .frame(width: sizeLimit, height: sizeLimit)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        DrawBoard(board: gameData.board)
                            .frame(width: sizeLimit, height: sizeLimit)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    }
                    .aspectRatio(contentMode: .fit)
                    Text(presentResult())
                        .rotationEffect(Angle(degrees: 5))
                        .underline()
                        .padding(.top, 50)
                    Text("Play Again!")
                        .rotationEffect(Angle(degrees: -5))
                        .opacity(wasPressedPlayAgain ? 0.5 : 1.0)
                        .padding(.top, 50)
                        .onTapGesture {
                            try? playSound($buttonSoundEffect, buttonSoundEffectURL)
                        }
                        .buttonAnimation(wasPressed: $wasPressedPlayAgain) { playAgain = true }
                    Text("Home")
                        .rotationEffect(Angle(degrees: 5))
                        .opacity(wasPressedHome ? 0.5 : 1.0)
                        .padding(.top, 50)
                        .onTapGesture {
                            try? playSound($buttonSoundEffect, buttonSoundEffectURL)
                        }
                        .buttonAnimation(wasPressed: $wasPressedHome) { dismiss() }
                    Spacer()
                }
                .padding(10)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.crewOrange)
                .shadow(color: .gray, radius: 8, x: 5, y: -5)
                .navigationDestination(isPresented: $playAgain) {
                    GameView(vsComputer ? true : false)
                        .navigationBarBackButtonHidden()
                }
                .onAppear {
                    try? playSound($resultSoundEffect, Bundle.main.url(forResource: "level-up-3", withExtension: "mp3"))
                }
            }
        }
    }
}

#Preview {
    ResultView(GameData(), false, false)
}


private extension ResultView {
    func playSound(_ soundEffect: Binding<AVAudioPlayer?>, _ url: URL?) throws {
        Task {
            guard let url = url else { throw SoundError.nilURL() }
            soundEffect.wrappedValue = try AVAudioPlayer(contentsOf: url)
            soundEffect.wrappedValue?.play()
            try await Task.sleep(nanoseconds: 200_000_000)
        }
    }
    
    func presentResult() -> String {
        guard let result = gameData.result else { return "It's a Draw!" }
        switch result {
            case "Player X":
                if vsComputer == true && computerIsPlayerX == true {
                    return "Computer won"
                } else {
                    return "Player X won"
                }
            default:
                if vsComputer == true && computerIsPlayerX == false {
                    return "Computer won"
                } else {
                    return "Player O won"
                }
        }
    }
}
