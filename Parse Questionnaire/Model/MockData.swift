// Project: Parse Questionnaire
//
// This file contains a bunch of extensions of the base data. They are used to generate mock data
// that we can display when designing in XCode.
//

import Foundation

extension Review {

    // MARK:- Dummy review for design purposes in XCode.
    
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


extension User {
    
    // MARK:- Dummy user used for design purposes in XCode
    static func dummy() -> User {
        User(name: "Dummy",
             email: "dummy@dummy.com",
             password: Auth.encrypt("dummy"))
    }
}

extension Unit {
    
    static var dummyData: Unit {
        Unit(id: "A1",
             title: "Unit A1 title",
             analysisText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")
    }

    static var empty: Unit {
        Unit(id: "", title: "", analysisText: "")
    }
}

extension Question {
    static var empty: Question {
        Question(id: -1, question: "", targetIfYes: -1, targetIfNo: -1, targetIfUnsure: -1, unitsIfYes: "", unitsIfNo: "", unitsIfUnsure: "")
    }
}
