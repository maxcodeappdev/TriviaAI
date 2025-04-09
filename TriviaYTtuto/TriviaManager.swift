//
//  TriviaManager.swift
//  TriviaYTtuto
//
//  Created by Max Contreras on 4/8/25.
//

import Foundation
import SwiftUICore


class TriviaManager: ObservableObject {
  struct Quiz: Decodable {
    struct Question: Decodable {
      struct Option: Decodable, Identifiable {
        
        let id = UUID()
        let content: String
        
        let correct: Bool
        
        enum CodingKeys: String, CodingKey {
          case content
          case correct
        }
      }
      
      let content: String
      let options: [Option]
      let answerExplanation: String
    }
    
    let questions: [Question]
  }
  
  /// game state
  
  enum GameState {
    case menu, game, answerCorrect, answerWrong, gameOver
    
    func bgColor() -> Color {
      switch self {
        
      case .menu:
        return .primaryYellow
        
      case .game:
        return .bgPurple
        
      case .answerCorrect:
        return .bgLightBlue
        
      case .answerWrong:
        return .bgPink
        
      case .gameOver:
        return .bgBlue
      }
    }
    
  }
  
  
  private let aiProvider = AIProvider()
  
  
  @Published public var questions = [Quiz.Question]()
  @Published public var gameState = GameState.menu
  @Published public var questionsCorrect = 0
  
  
  private func fetchQuiz (prompt: String) async -> Quiz? {
    guard let response = await aiProvider.runInference(prompt: prompt),
          let quizString = response.choices.first?.message.content else { return nil }
    
    
    do {
      
      let parsedQuiz = try JSONDecoder().decode(Quiz.self, from: Data(quizString.utf8))
      return parsedQuiz
      
    } catch {
      print(error)
      return nil
      
    }
    
    
    
  }
  
  @MainActor
  public func startQuiz(topic: String) async {
    
      guard let quiz = await self.fetchQuiz(prompt: topic) else {
        print("Failed to fetch quiz")
        return
      }
      
      questions = quiz.questions
      gameState = GameState.game
      questionsCorrect = 0
      
      
      
      
    
    
    
    
    
  }
  
  
  public func answerQuestion(correct: Bool) {
    if correct {
      questionsCorrect += 1
      gameState = .answerCorrect
    } else {
      gameState = .answerWrong
        }
  }
    
  public func nextQuestion() {
    questions.removeFirst()
    
    if questions.count > 0 {
      gameState = .game
      
    }
    else {
      gameState = .gameOver
    }
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
}
