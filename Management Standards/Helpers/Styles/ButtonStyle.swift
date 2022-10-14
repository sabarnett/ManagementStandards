// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct AppButtonStyle: ButtonStyle {
    var frameWidth: CGFloat = 60
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(width: frameWidth, height: 20)
            .foregroundColor(.primary)
            .padding()
            .background(
                ZStack {
                    RoundedRectangle(
                        cornerRadius: 12,
                        style: .continuous
                    )
                    .fill(Color(.systemGray5))
                    RoundedRectangle(
                        cornerRadius: 12,
                        style: .continuous
                    )
                    .stroke(lineWidth: 1)
                }
        )
    }
}
