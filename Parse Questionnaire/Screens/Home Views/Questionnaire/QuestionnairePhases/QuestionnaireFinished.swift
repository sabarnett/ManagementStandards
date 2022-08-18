// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct QuestionnaireFinished: View {
    
    @EnvironmentObject var viewModel: AppData
    @StateObject var questions: Questionnaire
    @Binding var phase: QuestionnairePhase
    
    var body: some View {
        VStack(alignment: .leading, spacing: 35) {
            Spacer()
            
            Text("**Congratulations** you have completed the questionnaire.")
                .font(.title2)
            
            Text("When you tap the __Begin Analysis__ button, your answers will be saved and analysed to determine which units you need to concentrate on.")
            
            Text("Press the button to get started.")
                .padding(.bottom, 30)
            
            HStack {
                Spacer()
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
            
            Spacer()
        }.padding()
    }
}

struct QuestionnaireFinished_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireFinished(questions: Questionnaire(),
            phase: .constant(.titles))
        .environmentObject(AppData())
    }
}
