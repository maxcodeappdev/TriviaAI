//
//  GameOverView.swift
//  TriviaYTtuto
//
//  Created by Max Contreras on 4/9/25.
//

import SwiftUI

struct GameOverView: View {
  @EnvironmentObject var triviaManager: TriviaManager
  
  var scorePercentage: Int {
    Int(
      Double(
        100*triviaManager.questionsCorrect/AIConfig.maxQuestions
      )
      .rounded()
    )
  }
  
  
    var body: some View {
      
      
      
      VStack {
        
        
        
        Text("Game Over")
          .font(.system(size: 56))
          .bold()
        
        Text("Score: \(triviaManager.questionsCorrect)/\(AIConfig.maxQuestions) (\(scorePercentage)%)")
          .font(.headline)
        
        
        Button{
          
          triviaManager.gameState = .menu
        }
        label: {
          Text("Play Again")
           
            .padding()
            .padding(.horizontal)
        }
        .buttonStyle(OutlineButtonStyle(shape: AnyShape(Capsule(style: .continuous))))
        .padding(.top, 48)
        
      }
      
      
      
    }
}

#Preview {
    GameOverView()
    .environmentObject(TriviaManager() )
}
