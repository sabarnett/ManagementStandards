// Project: Management Standards
//
//  Presents the questions and answers to the user. As the user answers a question
//  we have the answer and move on to the next question. It is worth noting that the
//  questions are not linear. The next question to be asked is dependent on the
//  answer they gave.
//

import SwiftUI

struct QuestionPrompts: View {
    
    @StateObject var questions: Questionnaire
    @Binding var phase: QuestionnairePhase
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .center) {
                Spacer()
                
                QuestionPromptView(question: questions.currentQuestion)
                    .padding()
                
                Spacer()
                
                AnswerButtonsView() { button in
                    questions.addAnswer(buttonPress: button)
                    }
                Spacer()
            }
            .onChange(of: questions.isComplete) { newvalue in
                if questions.isComplete {
                    phase = .save
                }
            }
        }
    }
}

struct QuestionPrompts_Previews: PreviewProvider {
    @StateObject static var questions = Questionnaire()
    
    static var previews: some View {
        QuestionPrompts(questions: questions,
                        phase: .constant(.questionnaire))
    }
}
