//
//  ContentView.swift
//  TriviaYTtuto
//
//  Created by Max Contreras on 4/8/25.
//

import SwiftUI

struct ContentView: View {
  @StateObject var triviaManager = TriviaManager()
  
  
    var body: some View {
      
      
      
      
      ZStack {
        
        Image(.bg)
          .resizable(resizingMode: .tile)
          .ignoresSafeArea()
          .background(triviaManager.gameState.bgColor())
        
       
        switch triviaManager.gameState {
        case .menu:
          MenuView()
        case .gameOver:
          GameOverView()
        default:
          GameView()
        }
        
        
      }
      .environmentObject(triviaManager)
      .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
