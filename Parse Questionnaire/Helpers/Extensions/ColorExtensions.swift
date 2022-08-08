// Project: Parse Questionnaire
//
//  
//

import SwiftUI

extension Color {
  init(_ hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xFF) / 255,
      green: Double((hex >> 8) & 0xFF) / 255,
      blue: Double(hex & 0xFF) / 255,
      opacity: alpha
    )
  }
    
    static var buttonBackground: Color = Color("buttonBackgroundColor")
    static var buttonForeground: Color = Color("buttonForegroundColor")
    
    static var backgroundStart: Color = Color("backgroundStart")
    static var backgroundEnd: Color = Color("backgroundEnd")
    
    static var titleColor: Color = Color("titleColor")
    
    static var popupBackground: Color = Color("popupBackground")
}


