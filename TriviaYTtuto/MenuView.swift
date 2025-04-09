//
//  MenuView.swift
//  TriviaYTtuto
//
//  Created by Max Contreras on 4/8/25.
//

import SwiftUI

struct MenuView: View {
  
  @EnvironmentObject var triviamanager: TriviaManager
  @State var topic = ""
  @State var disableInput: Bool = false
  
    var body: some View {
      VStack {
        Spacer()
        Image(.title)
          .resizable()
          .scaledToFit()
          .padding()
        
        Spacer()
        
        ///input quiz topic
        TextField("quiz topic", text:  $topic )
          .disabled(disableInput)
          .padding()
          .padding(.bottom, 16)
          .textFieldStyle(RoundTextFieldStyle())
        
        
        Button {
          Task{
            disableInput = true
            await triviamanager.startQuiz(topic: topic)
            disableInput = false
          }
        } label: {
          Text("Start Quiz")
            .padding()
            .padding(.horizontal)
        }
        .disabled(disableInput )
        .buttonStyle(OutlineButtonStyle(
          shape: AnyShape(Capsule(style: .continuous)),
          colorOverride: .bgLightBlue
        ))
        
        
        
        HStack {
          Text("loading...")
            .font(.caption)
            .foregroundStyle(.secondary)
          ProgressView()
        }
        .padding(.top, 8)
        .opacity(disableInput ? 1 : 0)
        
        Spacer()
        
        
      }
      .padding()
    }
}

#Preview {
    MenuView()
}
