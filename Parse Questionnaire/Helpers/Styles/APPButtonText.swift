// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct APPButtonText: View {
    
    var caption: String
    var buttonWidth: CGFloat? = nil
    var buttonHeight: CGFloat = 50
    var backgroundColor: Color = Color.buttonBackground
    var foregroundColor: Color = Color.buttonForeground
    
    var body: some View {
        Text(caption)
            .font(.title3)
            .fontWeight(.semibold)
            .padding()
            .frame(width: buttonWidth, height: buttonHeight)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .cornerRadius(14)
    }
}

struct ApButtonText_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            APPButtonText(caption: "Hello Steve", buttonWidth: 280)
                .previewLayout(.sizeThatFits)
            APPButtonText(caption: "Hello Steve")
                .previewLayout(.sizeThatFits)
            APPButtonText(caption: "Hello Steve", buttonHeight: 35)
                .previewLayout(.sizeThatFits)
            APPButtonText(caption: "Hello Steve",
                          backgroundColor: Color(.systemRed),
                          foregroundColor: Color.white)
                .previewLayout(.sizeThatFits)
        }
    }
}
