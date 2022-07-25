// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct QuestionPromptView: View {
    
    let question: Question

    var body: some View {
        ZStack {
            Text(question.question)
                .padding()
                .frame(minWidth: 200, idealWidth: 250, maxWidth: 600, minHeight: 170, idealHeight: 170, maxHeight: 200, alignment: .center)
                .foregroundColor(.primary)
                .transition(AnyTransition.opacity.animation(.easeIn (duration:0.3)) )
                .id(question.id)
        }
        .background {
            Color(.systemGray5)
                .cornerRadius(28)
//                .shadow(color: Color.secondary, radius: 4, x: 3, y: 3)
            }
    }
}

struct QuestionPrompt_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QuestionPromptView(question: Question.empty)
                .previewLayout(.sizeThatFits)
            QuestionPromptView(question: Question.empty)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
