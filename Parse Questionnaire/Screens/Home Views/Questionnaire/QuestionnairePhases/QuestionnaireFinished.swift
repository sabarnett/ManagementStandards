// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct QuestionnaireFinished: View {
    
    @ObservedObject var viewModel: HomeTabViewModel
    @ObservedObject var questions: Questionnaire
    @Binding var phase: QuestionnairePhase
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()
            Text("You have completed the questionnaire. Press the button.")
            
            Button(action: {
                // Save the answers to the reviews list
                questions.saveReview(to: viewModel)

                // Return to the caller so they can display the results
                phase = .finished
            }, label: {
                APPButtonText(caption: "Begin Analysis")
            })
            Spacer()
        }
    }
}

//struct QuestionnaireFinished_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionnaireFinished()
//    }
//}
