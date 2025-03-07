//
//  EntryView.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 11/19/24 at 7:32 PM.
//

import SwiftUI

struct EntryView: View {
    @State private var viewModel = EntryViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                #if os(iOS)
                Color(.crewDarkGray).ignoresSafeArea()
                #endif
                content
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .shadow(color: .gray, radius: 20, x: 5, y: -5)
                    .navigationDestination(isPresented: $viewModel.vsPlayerWasPressed) {
                        GameView(false)
                            .navigationBarBackButtonHidden()
                    }
                    .navigationDestination(isPresented: $viewModel.vsComputerWasPressed) {
                        GameView(true)
                            .navigationBarBackButtonHidden()
                    }
            }
            .foregroundStyle(.crewOrange)
            #if os(macOS)
            .padding(.bottom)
            #endif
        }
    }
    
    @ViewBuilder private var content: some View {
        VStack {
            
            Text("Tic Tac Toe")
                .rotationEffect(Angle(degrees: -5))
                .padding(.top, 25)
            
            GeometryReader { geometry in
                
                let sizeLimit = min(geometry.size.width, geometry.size.height) * 0.8
                let xPosition = geometry.size.width / 2
                let yPosition = geometry.size.height / 2
                
                Grid(.crewPurple, 4)
                    .frame(width: sizeLimit, height: sizeLimit)
                    .position(x: xPosition, y: yPosition)
                
                DrawBoard()
                    .frame(width: sizeLimit, height: sizeLimit)
                    .position(x: xPosition, y: yPosition)
            }
            .scaledToFit()
            
            playButton("VS Player!", $viewModel.vsPlayerWasPressed, 5)
            
            playButton("VS Computer!", $viewModel.vsComputerWasPressed, -5)
            
            Spacer()
        }
    }
    
    @ViewBuilder private func playButton(_ title: String, _ wasPressed: Binding<Bool>, _ rotation: Double) -> some View {
        Text(title)
            .rotationEffect(Angle(degrees: rotation))
            .padding(.top, 25)
            .onTapGesture {
                viewModel.buttonSoundEffect.play()
                wasPressed.wrappedValue.toggle()
            }
            .buttonReturnAnimation(wasPressed.wrappedValue)
    }
}

#Preview {
    EntryView()
}
