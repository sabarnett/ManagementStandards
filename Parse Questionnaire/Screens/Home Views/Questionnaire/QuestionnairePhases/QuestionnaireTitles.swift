// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct QuestionnaireTitles: View {
    
    @ObservedObject var viewModel: HomeTabViewModel
    @ObservedObject var questions: Questionnaire
    @Binding var phase: QuestionnairePhase
    
    @State var reviewTitle: String = ""
    @State var reviewDescription: String = ""

    
    var body: some View {
        VStack(alignment: .center, spacing: 25) {
            Form {
                Section(footer: Text("Use the title to identify your review in lists.")) {
                    TextField("Title", text: $reviewTitle)
                }
                
                Section(footer: Text("Enter a short description of why you are performing this review")) {
                    TextEditor(text: $reviewDescription)
                        .lineLimit(5)
                        .frame(minHeight: 250)
                }
                
                Section() {
                HStack {
                    Spacer()
                    Button {
                        if !validateAndSetTitles() { return }

                        phase = .questionnaire
                    } label: {
                        APPButtonText(caption: "Begin Questionnaire")
                    }
                    Spacer()
                }}.listRowBackground(Color.clear)
            }
            
            Spacer()
        }
    }
    
    func validateAndSetTitles() -> Bool {
        questions.reviewTitle = reviewTitle
        if questions.alertItem != nil { return false }
        
        questions.reviewDescription = reviewDescription
        if questions.alertItem != nil { return false }
        
        return true
    }
}

//struct QuestionnaireTitles_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionnaireTitles()
//    }
//}
