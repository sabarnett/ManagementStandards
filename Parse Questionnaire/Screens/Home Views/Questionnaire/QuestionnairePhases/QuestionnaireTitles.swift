// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct QuestionnaireTitles: View {
    
    @ObservedObject var viewModel: HomeTabViewModel
    @ObservedObject var questions: Questionnaire
    @Binding var phase: QuestionnairePhase
    
    var body: some View {
        VStack(alignment: .center, spacing: 25) {
            Spacer()
            
            Button {
                phase = .questionnaire
            } label: {
                APPButtonText(caption: "Begin Questionnaire")
            }
            
            Spacer()
        }
    }
}

//struct QuestionnaireTitles_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionnaireTitles()
//    }
//}
