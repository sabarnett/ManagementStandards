// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct QuestionPrompts: View {
    
    @ObservedObject var viewModel: HomeTabViewModel
    @ObservedObject var questions: Questionnaire
    @Binding var phase: QuestionnairePhase
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .center) {
                Spacer()
                
                QuestionPromptView(question: questions.currentQuestion)
                    .padding()
                
                Spacer()
                
                AnswerButtonsView() {
                    button in
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
//
//struct QuestionPrompts_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionPrompts()
//    }
//}
