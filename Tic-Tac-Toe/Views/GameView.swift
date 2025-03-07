//
//  GameView.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 11/19/24 at 8:14 PM.
//

import SwiftUI

struct GameView: View {
    @State private var viewModel: GameViewModel
    
    init(_ vsComputer: Bool) {
        self._viewModel = State(initialValue: GameViewModel(vsComputer))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                #if os(iOS)
                Color(.crewDarkGray).ignoresSafeArea()
                #endif
                content
                    .padding(10)
                    .fontWeight(.black)
                    .foregroundStyle(.crewOrange)
                    .shadow(color: .gray, radius: 8, x: 5, y: -5)
                    .onChange(of: viewModel.gameData.turnCount, initial: true) {
                        viewModel.computerMove()
                    }
                    .navigationDestination(isPresented: $viewModel.gameOver) {
                        ResultView(viewModel.gameData, viewModel.vsComputer, viewModel.computerIsPlayerX)
                            .navigationBarBackButtonHidden()
                    }
            }
        }
    }
    
    @ViewBuilder private var content: some View {
        VStack {
            Text(viewModel.newPlayerTurn())
                .font(.title)
                .rotationEffect(Angle(degrees: -2.5))
                .padding(.top, 10)
            
            GeometryReader { geometry in
                
                let sizeLimit = min(geometry.size.width, geometry.size.height) * 0.8
                let xPosition = geometry.size.width / 2
                let yPosition = geometry.size.height / 2
                
                Grid(.crewPurple, 4)
                    .frame(width: sizeLimit, height: sizeLimit)
                    .position(x: xPosition, y: yPosition)
                
                DrawBoard(
                    board: viewModel.gameData.board,
                    action: { index in viewModel.playerMove(index: index) },
                    modifier: { view, index in boardModifier(view, index) }
                )
                    .frame(width: sizeLimit, height: sizeLimit)
                    .position(CGPoint(x: xPosition, y: yPosition))
            }
            .aspectRatio(contentMode: .fit)
            
            Spacer()
        }
    }
    
    private func boardModifier(_ view: some View, _ index: Int) -> some View {
        view
            .scaleEffect(viewModel.tappedIndex == index ? 1.05 : 1.0)
            .animation(.spring, value: viewModel.tappedIndex)
    }
}

#Preview {
    GameView(false)
}
