// Project: Parse Questionnaire
//
//  
//

import Foundation

struct QuestionnaireData: Codable {
    var introduction: Introduction
    var questions: [Question]
    var units: [Unit]
    
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
