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
            QandA(id: 1, question: "Question 1", answer: "Yes", units: "A1, A2, A3"),
            QandA(id: 2, question: "Question 2", answer: "No", units: ""),
            QandA(id: 3, question: "Question 3", answer: "Unsure", units: "A1, A3")
        ],
        units: [
            Unit(id: "A1",
                 title: "Unit A1 Title",
                 analysisText: "This is the **analysis** text for unit __A1__"),
            Unit(id: "A2",
                 title: "Unit A2 Title",
                 analysisText: "This is the analysis text for unit A2. This is the analysis text for unit A2. This is the analysis text for unit A2"),
            Unit(id: "A3",
                 title: "Unit A3 Title",
                 analysisText: "This is the analysis text for unit A3. This is the analysis text for unit A3"),
        ])
}

struct QandA: Codable, Identifiable {
    var id: Int                 // Question Number
    var question: String
    var answer: String
    var units: String
    
    func unitText(unitText: [Unit]) -> [Unit] {
        guard !units.isEmpty else { return [] }
        
        let unitList = units.components(separatedBy: CharacterSet(charactersIn: "&,"))
        let result = unitList.map({ unit -> Unit in
            let trimmedUnit = unit.trimmingCharacters(in: CharacterSet([" "]))
            return unitText.first(where: { $0.id == trimmedUnit })!
        })
        return result
    }
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
