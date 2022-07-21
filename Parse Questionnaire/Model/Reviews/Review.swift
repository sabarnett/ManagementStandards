// Project: Parse Questionnaire
//
//  
//

import Foundation

struct ReviewList: Codable {
    var reviews: [Review]
}

struct Review: Codable, Identifiable {
    var id: UUID = UUID()
    var created: Date
    var title: String
    var description: String
    var QA: [QandA]
    var units: [Unit]

    static var dummyData: Review = Review(
        id: UUID(),
        created: Date.now,
        title: "Dummy Review",
        description: "This was a dummy review created for testing purposes. It contains a limited number of responses and units.",
        QA: [
            QandA(id: 1, question: "Question 1", Answer: "Yes", units: "A1, A2, A3"),
            QandA(id: 2, question: "Question 2", Answer: "No", units: ""),
            QandA(id: 3, question: "Question 3", Answer: "Unsure", units: "A1, A3")
        ],
        units: [
            Unit(id: "A1", analysisText: "This is the **analysis** text for unit __A1__"),
            Unit(id: "A2", analysisText: "This is the analysis text for unit A2. This is the analysis text for unit A2. This is the analysis text for unit A2"),
            Unit(id: "A3", analysisText: "This is the analysis text for unit A3. This is the analysis text for unit A3"),
        ])
}

struct QandA: Codable, Identifiable {
    var id: Int                 // Question Number
    var question: String
    var Answer: String
    var units: String
}

extension Review {

    var unitCount: Int { units.count }
    
    var questionCount: Int { QA.count }
    
    var createdDateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM y - HH:mm "
        return formatter.string(from: created)
    }

}
