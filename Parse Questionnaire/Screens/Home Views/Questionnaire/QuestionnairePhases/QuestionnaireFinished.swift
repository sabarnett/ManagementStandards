// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct QuestionnaireFinished: View {
    
    @ObservedObject var viewModel: HomeTabViewModel
    @ObservedObject var questions: Questionnaire
    @Binding var phase: QuestionnairePhase
    var closeForm: () -> Void
    
    var body: some View {
        VStack {
            
            Text("You have completed the questionnaire. Press the button.")
            
            Button(action: {
                // Save the answers to the reviews list
                questions.saveReview(to: viewModel)

                // Return to the caller so they can display the results
                closeForm()
            }, label: {
                APPButtonText(caption: "Begin Analysis")
            })
        }
    }
}

//struct QuestionnaireFinished_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionnaireFinished()
//    }
//}
