//
//  ContentView.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 11/19/24 at 7:32 PM.
//

import SwiftUI

struct ContentView: View {
    @State private var wasPressed = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Tic Tac Toe")
                    .rotationEffect(Angle(degrees: -5))
                    .padding(.top, 50)
                Helper.DrawBoard()
                Text("VS Player!")
                    .phaseAnimator([false, true], trigger: wasPressed) { content, phase in
                        content.scaleEffect(phase ? 1.10 : 1.0)
                    } animation: { phase in
                        phase ? .spring.speed(2.0) : .easeIn.speed(2.0)
                    }
                    .onTapGesture {
                        wasPressed.toggle()
                    }
                    .rotationEffect(Angle(degrees: 5))
                    .padding(.top, 50)
                Text("VS Computer!")
                    .rotationEffect(Angle(degrees: -5))
                    .padding(.top, 50)
                Spacer()
                    
            }
            .font(.largeTitle)
            .fontWeight(.black)
            .background(.crewDarkGray)
            .foregroundStyle(.crewOrange)
            .navigationDestination(isPresented: $wasPressed) {
                GameView()
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    ContentView()
}
