// Project: Management Standards
//
//  Contains the data for a questionnaire. 
//

import Foundation

struct QuestionnaireData: Codable {
    
    // MARK: - Persistable data
    
    var introduction: Introduction
    var questions: [Question]
    var units: [Unit]
}

extension QuestionnaireData {

    // MARK: - Computed Properties
    
    var reportIntroduction: String {
        self.introduction.report
    }
    
    var questionsIntroduction: String {
        self.introduction.questions
    }
}

extension QuestionnaireData {
    
    // MARK: - Computed accessors
    
    func question(withId: Int) -> Question {
        guard let question = questions.first(where: { $0.id == withId } ) else {
            return Question.empty
        }
        return question
    }
    
    func unit(withId: String) -> Unit {
        guard let unit = units.first(where: { $0.id == withId } ) else {
            return Unit.empty
        }
        return unit
    }
}
