// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct QuestionnaireView: View {
    
    @StateObject var questions = Questionnaire()
    @State private var showAnalysis: Bool = false
    
    var body: some View {
        ZStack {
            PopupBackgroundView()
            
            VStack(alignment: .leading) {
                QuestionnaireTitleView()
                    .padding(.horizontal)
                Spacer()
                
                VStack(alignment: .center) {
                    Spacer()
                    
                    QuestionPromptView(question: questions.currentQuestion)
                        .padding()
                    
                    Spacer()
                    
                    if questions.isComplete {
                        NavigationLink(destination: ResultUnitsView(review: Review.dummyData),
                                       isActive: $showAnalysis,
                                       label: {
                            Button(action: {
                                showAnalysis = true
                            }, label: {
                                APPButtonText(caption: "Begin Analysis")
                            }
                            )
                        })
                        
                    } else {
                        AnswerButtonsView() {
                            button in
                            questions.addAnswer(buttonPress: button)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            Button {
                showAnalysis = true
            } label: {
                XDismissButton()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireView()
    }
}
