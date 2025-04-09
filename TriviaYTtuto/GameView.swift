//
//  GameView.swift
//  TriviaYTtuto
//
//  Created by Max Contreras on 4/8/25.
//

import SwiftUI

struct GameView: View {
  
  @EnvironmentObject var triviaManager: TriviaManager
  @State var chosenOption: TriviaManager.Quiz.Question.Option?
  
  var choseOption: Bool {
    chosenOption != nil
  }
  
  
  var body: some View {
    
    
    VStack {
      
      if let question = triviaManager.questions.first {
        
        Text(question.content)
          .font(.title)
          .bold()
        
        Spacer()
        
        VStack(spacing: 20) {
          ForEach(question.options) { option in
            
            let buttonColor: Color = {
                if choseOption && option.correct {
                    return .buttonGreen
                } else if chosenOption?.id == option.id {
                    return .buttonRed
                } else {
                    return .primaryYellow
                }
            }()
            
            Button {
              chosenOption = option
              triviaManager.answerQuestion(correct: option.correct)
            } label: {
              Text(option.content)
                .padding()
                .frame(maxWidth: .infinity)
                .fixedSize(horizontal: false, vertical: true)
            }
            .buttonStyle(OutlineButtonStyle(shape: AnyShape(RoundedRectangle(cornerRadius: 16, style: .continuous)), colorOverride: buttonColor))
            .disabled(choseOption)
            
            
          }
        }
        
        Spacer()
        
        HStack{
          
          Text("\(triviaManager.gameState == .answerCorrect ? "Correct!" : "Incorrect") - \(question.answerExplanation)")
            .font(.callout)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
          
          Button {
          chosenOption = nil
          triviaManager.nextQuestion()
          } label: {
            Image(systemName: "arrow.right")
              .imageScale(.large)
              .padding (12)
         
          }     .buttonStyle(OutlineButtonStyle(
            shape: AnyShape(Circle())
          ))
          .disabled(!choseOption)
          
        }
        .padding()
        .background(
          RoundedRectangle(cornerRadius: 16, style: .continuous)
            .stroke(.black, lineWidth: 4)
            .fill(.bgBlue)
        
        )
        ///this opacity hide it
        .opacity(choseOption ? 1 : 0)
        
      }

    }
    .padding()
    .multilineTextAlignment(.center)
    
  }
  
}

#Preview {
  let triviaManager = TriviaManager()
  triviaManager.questions = [
    .init(content: "Lorem ipsum dolor sit amet consect elit libero nunc?", options: [
      .init(content: "Correct Lorem ipsum dolor sit amet", correct: true),
      .init(content: "Lorem ipsum dolor sit amet", correct: false),
      .init(content: "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet", correct: false),
      .init(content: "Lorem ipsum dolor sit amet", correct: false),
    ],
          answerExplanation: "Lorem ipsum dolor sit amet consectetur. Lorem ipsum dolor sit amet consectetur.")
  ]
  triviaManager.gameState = .game
  return GameView().environmentObject(triviaManager)
}
