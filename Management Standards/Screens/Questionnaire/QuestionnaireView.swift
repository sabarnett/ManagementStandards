// Project: Management Standards
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
    
    @EnvironmentObject var viewModel : AppData
    @Binding var showQuestionnaire: Bool
    
    @StateObject var questions = Questionnaire()
    @State private var showWarning: MessageItem?
    
    @State private var phase: QuestionnairePhase = .titles
    
    var body: some View {
        ZStack {
            PopupBackgroundView()
            
            VStack {
                QuestionnaireTitleView()
                    .padding(.horizontal)
                
                if phase == .titles {
                    // Get the questionnaire title and the user notes
                    QuestionnaireTitles(questions: questions, phase: $phase)
                } else if phase == .questionnaire {
                    // Display the questionnaire and gather results
                    QuestionPrompts(questions: questions, phase: $phase)
                } else if phase == .save {
                    // Finished - display the confirmation text and
                    // the begin analysis button
                    QuestionnaireFinished(questions: questions, phase: $phase)
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            Button { showWarning = MessageContext.confirmQuit }
                     label: { XDismissButton() }
        }
        .onChange(of: phase) { newValue in
            if newValue == .finished {
                showQuestionnaire = false
            }
        }
        .messageBox(message: $questions.messageItem)
        .messageBox(message: $showWarning) { response in
            
            showQuestionnaire = (response != .Primary)
            showWarning = nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireView(showQuestionnaire: .constant(true)) 
        .environmentObject(AppData())
    }
}
