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
        Button {
            phase = .questionnaire
        } label: {
            Text("Press for questionnaire")
        }
    }
}

//struct QuestionnaireTitles_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionnaireTitles()
//    }
//}
