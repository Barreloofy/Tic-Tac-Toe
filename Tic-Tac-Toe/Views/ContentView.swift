//
//  ContentView.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 11/19/24 at 7:32 PM.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var vsPlayerWasPressed = false
    @State private var vsComputerWasPressed = false
    @State private var buttonSoundEffect: AVAudioPlayer?
    private var soundEffectURL: URL?
    init() {
        soundEffectURL = try? Helper.configureSound(&buttonSoundEffect, "pop-1", "mp3")
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.crewDarkGray
                    .ignoresSafeArea()
                VStack {
                    Text("Tic Tac Toe")
                        .rotationEffect(Angle(degrees: -5))
                        .padding(.top, 50)
                    ZStack {
                        Grid()
                            .stroke(.crewPurple, lineWidth: 5)
                        Helper.DrawBoard()
                    }
                    .frame(width: 350, height: 350)
                    Text("VS Player!")
                        .buttonReturnAnimation(vsPlayerWasPressed)
                        .rotationEffect(Angle(degrees: 5))
                        .padding(.top, 50)
                        .onTapGesture {
                            try? playSound()
                            vsPlayerWasPressed.toggle()
                        }
                    Text("VS Computer!")
                        .rotationEffect(Angle(degrees: -5))
                        .padding(.top, 50)
                        .onTapGesture {
                            try? playSound()
                            vsComputerWasPressed.toggle()
                        }
                    Spacer()
                        
                }
                .padding(10)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.crewOrange)
                .shadow(color: .gray, radius: 8, x: 5, y: -5)
                .navigationDestination(isPresented: $vsPlayerWasPressed) {
                    GameView(false)
                        .navigationBarBackButtonHidden()
                }
                .navigationDestination(isPresented: $vsComputerWasPressed) {
                    GameView(true)
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }
}

private extension ContentView {
    func playSound() throws {
        guard let url = soundEffectURL else { throw SoundError.nilURL() }
        buttonSoundEffect = try AVAudioPlayer(contentsOf: url)
        buttonSoundEffect?.play()
    }
}

#Preview {
    ContentView()
}
