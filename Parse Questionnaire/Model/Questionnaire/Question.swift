// Project: Parse Questionnaire
//
//  
//

import Foundation

struct Question: Identifiable, Codable {
    var id: Int
    var question: String
    var targetIfYes: Int
    var targetIfNo: Int
    var targetIfUnsure: Int
    var unitsIfYes: String
    var unitsIfNo: String
    var unitsIfUnsure: String
    
    static var empty: Question {
        Question(id: -1, question: "", targetIfYes: -1, targetIfNo: -1, targetIfUnsure: -1, unitsIfYes: "", unitsIfNo: "", unitsIfUnsure: "")
    }
}
