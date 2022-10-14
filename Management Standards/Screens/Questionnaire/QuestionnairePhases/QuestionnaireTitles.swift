// Project: Management Standards
//
// Questionnaire part 1: Collect the title and short description of the review.
//

import SwiftUI

struct QuestionnaireTitles: View {
    
    @StateObject var questions: Questionnaire
    @Binding var phase: QuestionnairePhase
    
    @State var reviewTitle: String = ""
    @State var reviewDescription: String = ""

    enum Field: Hashable {
        case title
        case description
    }
    
    @FocusState private var focusField: Field?

    var body: some View {
        VStack(alignment: .center, spacing: 25) {
            Form {
                Section(footer: Text("Use the title to identify your review in lists.")) {
                    TextField("Title", text: $reviewTitle)
                        .focused($focusField, equals: .title)
                        .onAppear() {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6){ focusField = .title }
                        }
                }
                
                Section(footer: Text("Enter a short description of why you are performing this review")) {
                    TextEditor(text: $reviewDescription)
                        .focused($focusField, equals: .description)
                        .lineLimit(5)
                        .frame(minHeight: 200)
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
        if questions.messageItem != nil {
            focusField = .title
            return false
        }
        
        questions.reviewDescription = reviewDescription
        if questions.messageItem != nil {
            focusField = .description
            return false
        }
        
        return true
    }
}

struct QuestionnaireTitles_Previews: PreviewProvider {
    @StateObject static var questions = Questionnaire()
    
    static var previews: some View {
        QuestionnaireTitles(questions: questions,
                            phase: .constant(.titles))
    }
}
