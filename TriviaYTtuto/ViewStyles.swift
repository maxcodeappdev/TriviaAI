//
//  ViewStyles.swift
//  TriviaYTtuto
//
//  Created by Max Contreras on 4/8/25.
//

import Foundation
import SwiftUI



struct RoundTextFieldStyle: TextFieldStyle {
  func _body(configuration: TextField<Self._Label>) -> some View {
    
    configuration
      .padding(.horizontal)
      .padding(.vertical, 8)
      .background(
       
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .stroke(.black, lineWidth: 4)
          .fill(.white)
        
      )
  }
  
}



struct OutlineButtonStyle: ButtonStyle {
  
  var shape: AnyShape
  var colorOverride: Color?
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
    
      .background(
        shape
          .stroke(.black, lineWidth: 4)
          .fill(colorOverride ?? .primaryYellow)
          .brightness(configuration.isPressed ? -0.1 : 0)
        
        
        
      )
      .foregroundStyle(.black)
    
    
    
  }
}
