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
        .onChange(of: phase) {
            newValue in
            if newValue == .finished {
                showQuestionnaire = false
            }
        }
        .overlay(alignment: .topTrailing) {
            Button { showWarning = true } label: { XDismissButton() }
        }
        .alert(isPresented: $showWarning) {
            AreYouSurePrompt()
        }
    }
    
    fileprivate func AreYouSurePrompt() -> Alert {
        return Alert(
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireView(viewModel: HomeTabViewModel(), showQuestionnaire: .constant(true))
    }
}
