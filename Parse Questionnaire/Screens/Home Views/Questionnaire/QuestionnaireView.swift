// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct QuestionnaireView: View {
    
    @ObservedObject var viewModel : HomeTabViewModel
    @Binding var showQuestionnaire: Bool

    @StateObject var questions = Questionnaire()
    @State private var showAnalysis: Bool = false
    @State private var showWarning: Bool = false
    
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
                                // Save the answers to the reviews list
                                
                                // Save the reviews list
                                
                                // Return to the caller so they can display the results
                                showQuestionnaire = false
                            }, label: {
                                APPButtonText(caption: "Begin Analysis")
                            })
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
                showWarning = true
            } label: {
                XDismissButton()
            }
        }
        .alert(isPresented: $showWarning) {
            Alert(
                title: Text("Are you sure you want to cancel?"),
                message: Text("If you close the questionnaire now, your answers will be discarded and the analysis will not be created."),
                primaryButton: .destructive(Text("Cancel")) {
                    print("Questionnaire cancelled...")
                    showQuestionnaire = false
                },
                secondaryButton: .default(Text("Continue")) {
                    showWarning = false
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireView(viewModel: HomeTabViewModel(), showQuestionnaire: .constant(true))
    }
}
