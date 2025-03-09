//
//  ResultView.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 11/21/24 at 8:15 PM.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: ResultViewModel
    
    init(_ gameData: GameData, _ vsComputer: Bool, _ computerIsPlayerX: Bool) {
        self._viewModel = State(initialValue: ResultViewModel(gameData, vsComputer, computerIsPlayerX))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                #if os(iOS)
                Color(.crewDarkGray).ignoresSafeArea()
                #endif
                content
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .shadow(color: .gray, radius: 8, x: 5, y: -5)
                    .padding(10)
                    .navigationDestination(isPresented: $viewModel.playAgain) {
                        GameView(viewModel.vsComputer ? true : false)
                            .navigationBarBackButtonHidden()
                    }
                    .onAppear {
                        viewModel.resultSoundEffect.play()
                    }
                    .onDisappear {
                        viewModel.buttonSoundEffect.stop()
                    }
            }
            .foregroundStyle(.crewOrange)
        }
    }
    
    
    @ViewBuilder private var content: some View {
        VStack {
            GeometryReader { geometry in
                
                let sizeLimit = min(geometry.size.width, geometry.size.height) * 0.8
                let xPosition = geometry.size.width / 2
                let yPosition = geometry.size.height / 2
                
                Grid(.crewPurple, 4)
                    .frame(width: sizeLimit, height: sizeLimit)
                    .position(x: xPosition, y: yPosition)
                
                DrawBoard(board: viewModel.gameData.board)
                    .frame(width: sizeLimit, height: sizeLimit)
                    .position(x: xPosition, y: yPosition)
            }
            .aspectRatio(contentMode: .fit)
            
            Text(viewModel.presentResult())
                .rotationEffect(Angle(degrees: 5))
                .underline()
                .padding(.top, 50)
            
            navigationButton("Play Again!", $viewModel.wasPressedPlayAgain, -5) { viewModel.playAgain = true }
            
            navigationButton("Home", $viewModel.wasPressedHome, 5) { dismiss() }
            
            Spacer()
            
        }
    }
    
    
    @ViewBuilder private func navigationButton(_ title: String, _ wasPressed: Binding<Bool>, _ rotation: Double, _ action: @escaping () -> Void) -> some View {
        Text(title)
            .rotationEffect(Angle(degrees: rotation))
            .opacity(wasPressed.wrappedValue ? 0.5 : 1.0)
            .padding(.top, 25)
            .onTapGesture {
                viewModel.buttonSoundEffect.play()
            }
            .buttonAnimation(wasPressed: wasPressed, completion: action)
    }
}

#Preview {
    ResultView(GameData(), false, false)
}
