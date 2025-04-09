//
//  AIProvider.swift
//  TriviaYTtuto
//
//  Created by Max Contreras on 4/8/25.
//

import Foundation

/// this struct is for the AI configurationto to make AI requests
struct AIConfig {
  
  public static let maxQuestions = 5
  
  
  /// here we set the instructions for the AI
  public static let systemMessage = """
    Create a quiz as a JSON object with \(maxQuestions) questions, each with only 4 options and only 1 correct option. The user will give you the topic, which you must follow. Use answerExplanation to provide a short explanation as to why that option is correct. The questions and options you generate must be concise. Always randomise the options array.
    The JSON object must use this schema:
    
    {
        "type": "object",
        "properties": {
            "questions": {
                "type": "array",
                "items": {
                    "type": "object",
                    "properties": {
                        "content": {
                            "type": "string"
                        },
                        "options": {
                            "type": "array",
                            "items": {
                                "type": "object",
                                "properties": {
                                    "content": {
                                        "type": "string"
                                    },
                                    "correct": {
                                        "type": "boolean"
                                    }
                                },
                                "required": [
                                    "content",
                                    "correct"
                                ]
                            }
                        },
                        "answerEXplanation": {
                            "type": "string"
                        }
                    },
                    "required": [
                        "content",
                        "options",
                        "answerExplanation"
                    ]
                }
            }
        },
        "required": [
            "questions"
        ]
    }
    """
  
  /// here the mode we can be chanced to any that you like
  public static let model = "llama-3.3-70b-specdec"
  
  /// here we add the request URL for the specific api we are using in this case we use groq, the force unwrap is becaue we know us a valid url
  public static let requestURL = URL(string: "https://api.groq.com/openai/v1/chat/completions")!
  
  
}



class AIProvider {
  
  
  struct Response: Decodable {
    
    
    struct Choice: Decodable {
      
      
      struct Message: Decodable {
        
        
        let role: String
        let content: String
      }
      
      let message: Message
      
    }
    
    let choices: [Choice]
    
    
  }
  
  public func runInference(prompt: String) async -> Response? {
    let payload: [String: Any] = [
      
      "model" : AIConfig.model,
      "messages" : [
     [
      "role" : "system",
      "content" : AIConfig.systemMessage
      
     ],
     
     [
      "role" : "user",
      "content" : prompt
      
     ]
     
     
      ],
      
      "response_format" : [
        "type" : "json_object"
      ]
    ]
    
    var request = URLRequest(url: AIConfig.requestURL)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = [
      "Content-Type": "application/json",
      "Authorization": "Bearer \(Secrets.API_KEY)"
    ]
    
    do {
      
      let payloadData = try JSONSerialization.data(withJSONObject: payload)
      request.httpBody = payloadData
      
      let (data, response) = try await URLSession.shared.data(for: request)
      
      guard let response = response as? HTTPURLResponse,
            (200...299).contains(response.statusCode) else {
        print ("Response fail!")
        print(String(data: data, encoding: .utf8) ?? "No data!")
        return nil
      }
      
      let parsedResponse = try JSONDecoder().decode(Response.self, from: data)
      return parsedResponse
      
    } catch {
      print(error)
      return nil
      
    }
    
  }
  
}
