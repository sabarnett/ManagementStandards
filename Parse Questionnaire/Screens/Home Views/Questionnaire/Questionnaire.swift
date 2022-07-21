// Project: Parse Questionnaire
//
//  
//

import Foundation

class Questionnaire: ObservableObject {
    
    @Published var questionnaireData: QuestionnaireData? = QuestionnaireLoader.load(forName: "ManagementStandards")
    private var currentQuestionId = 1
    
    var currentQuestion: Question {
        guard let data = questionnaireData else { return Question.empty }
        return data.question(withId: currentQuestionId)
    }
    
    func addAnswer(buttonPress: ButtonPress) {
        switch buttonPress {
        case .yes:
            currentQuestionId = currentQuestion.targetIfYes
        case .no:
            currentQuestionId = currentQuestion.targetIfNo
        case .unsure:
            currentQuestionId = currentQuestion.targetIfUnsure
        }
        
        objectWillChange.send()
    }
    
    var isComplete : Bool {
        currentQuestion.targetIfNo == -1 && currentQuestion.targetIfYes == -1 && currentQuestion.targetIfUnsure == -1
    }
}


