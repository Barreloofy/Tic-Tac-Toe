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
    private var buttonSoundEffectURL: URL?
    let gameData: GameData
    init(_ gameData: GameData) {
        self.gameData = gameData
        self.buttonSoundEffectURL = try? Helper.configureSound(&buttonSoundEffect, "pop-1", "mp3")
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.crewDarkGray
                    .ignoresSafeArea()
                VStack {
                    ZStack {
                        Grid()
                            .stroke(.crewPurple, lineWidth: 5)
                        Helper.DrawBoard(gameData.board)
                    }
                    .frame(width: 350, height: 350)
                    Text(gameData.result != nil ? "\(gameData.result!) won" : "It's a Draw!")
                        .rotationEffect(Angle(degrees: 5))
                        .underline()
                        .padding(.top, 50)
                    Text("Play Again!")
                        .rotationEffect(Angle(degrees: -5))
                        .opacity(wasPressedPlayAgain ? 0.5 : 1.0)
                        .padding(.top, 50)
                        .onTapGesture {
                            Task {
                                try? playSound($buttonSoundEffect, buttonSoundEffectURL)
                                try await Task.sleep(nanoseconds: 150_000_000)
                            }
                        }
                        .buttonAnimation(wasPressed: $wasPressedPlayAgain) { playAgain = true }
                    Text("Home")
                        .rotationEffect(Angle(degrees: 5))
                        .opacity(wasPressedHome ? 0.5 : 1.0)
                        .padding(.top, 50)
                        .onTapGesture {
                            Task {
                                try? playSound($buttonSoundEffect, buttonSoundEffectURL)
                                try await Task.sleep(nanoseconds: 150_000_000)
                            }
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
                    GameView()
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
    ResultView(GameData())
}


private extension ResultView {
    func playSound(_ soundEffect: Binding<AVAudioPlayer?>, _ url: URL?) throws {
        guard let url = url else { throw SoundError.nilURL() }
        soundEffect.wrappedValue = try AVAudioPlayer(contentsOf: url)
        soundEffect.wrappedValue?.play()
    }
}
