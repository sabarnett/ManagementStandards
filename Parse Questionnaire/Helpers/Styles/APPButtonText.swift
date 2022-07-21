// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct APPButtonText: View {
    
    var caption: String
    var buttonWidth: CGFloat? = nil
    
    var body: some View {
        Text(caption)
            .font(.title3)
            .fontWeight(.semibold)
            .padding()
            .frame(width: buttonWidth, height: 50)
            .foregroundColor(Color.buttonForeground)
            .background(Color.buttonBackground)
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
        }
    }
}
