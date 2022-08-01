// Project: Parse Questionnaire
//
//  
//

import SwiftUI

enum QuestionnairePhase {
    case titles
    case questionnaire
    case save
    case finished
}

struct QuestionnaireView: View {
    
    @ObservedObject var viewModel : HomeTabViewModel
    @Binding var showQuestionnaire: Bool
    
    @StateObject var questions = Questionnaire()
    @State private var showWarning: Bool = false
    
    @State private var phase: QuestionnairePhase = .titles
    
    
    var body: some View {
        ZStack {
            PopupBackgroundView()
            
            VStack {
                QuestionnaireTitleView()
                    .padding(.horizontal)
                
                if phase == .titles {
                    // Get the questionnaire title and the user notes
                    QuestionnaireTitles(viewModel: viewModel, questions: questions, phase: $phase)
                } else if phase == .questionnaire {
                    // Display the questionnaire and gather results
                    QuestionPrompts(viewModel: viewModel, questions: questions, phase: $phase)
                } else if phase == .save {
                    // Finished - display the confirmation text and the begin analysis button
                    QuestionnaireFinished(viewModel: viewModel, questions: questions, phase: $phase)
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            Button {
                questions.alertItem = nil
                questions.showAlert = true
            } label: { XDismissButton() }
        }
        .onChange(of: phase) {
            newValue in
            if newValue == .finished {
                showQuestionnaire = false
            }
        }
        .alert(isPresented: $questions.showAlert) {
            if let alertItem = questions.alertItem {
                return Alert(title: alertItem.title,
                             message: alertItem.message,
                             dismissButton: .default(alertItem.dismissButton,
                                                     action: {
                        questions.showAlert = false
                        questions.alertItem = nil
                    })
                )
            } else {
                return AreYouSurePrompt()
            }
        }
    }
    
    fileprivate func AreYouSurePrompt() -> Alert {
        return Alert(
            title: Text("Are you sure you want to cancel?"),
            message: Text("If you close the questionnaire now, your answers will be discarded and the analysis will not be created."),
            primaryButton: .destructive(Text("Cancel")) {
                print("Questionnaire cancelled...")
                questions.showAlert = false
                showQuestionnaire = false
            },
            secondaryButton: .default(Text("Resume")) {
                questions.showAlert = false
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireView(viewModel: HomeTabViewModel(), showQuestionnaire: .constant(true))
    }
}
