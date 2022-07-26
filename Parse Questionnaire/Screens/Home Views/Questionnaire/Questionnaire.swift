// Project: Parse Questionnaire
//
//  
//

import Foundation

class Questionnaire: ObservableObject {
    
    @Published var questionnaireData: QuestionnaireData? = QuestionnaireLoader.load(forName: "ManagementStandards")
    private var currentQuestionId = 1
    private var review: Review = Review(created: Date.now,
                                        title: "Sample Review",
                                        description: "This is a sample review",
                                        QA: [],
                                        units: [])
    
    var currentQuestion: Question {
        guard let data = questionnaireData else { return Question.empty }
        return data.question(withId: currentQuestionId)
    }
    
    func addAnswer(buttonPress: ButtonPress) {
        
        let question = currentQuestion
        var qa = QandA(id: question.id,
                       question: question.question,
                       answer: "YesNoMaybe",
                       units: "")

        switch buttonPress {
        case .yes:
            qa.answer = "Yes"
            qa.units = question.unitsIfYes
            currentQuestionId = currentQuestion.targetIfYes
        case .no:
            qa.answer = "No"
            qa.units = question.unitsIfNo
            currentQuestionId = currentQuestion.targetIfNo
        case .unsure:
            qa.answer = "Unsure"
            qa.units = question.unitsIfUnsure
            currentQuestionId = currentQuestion.targetIfUnsure
        }
        
        review.QA.append(qa)
        objectWillChange.send()
    }
    
    var isComplete : Bool {
        currentQuestion.targetIfNo == -1 && currentQuestion.targetIfYes == -1 && currentQuestion.targetIfUnsure == -1
    }
    
    func saveReview(to viewModel: HomeTabViewModel) {
        // Resolve the unit list
        var unitList: Set<String> = Set<String>()
        for qa in review.QA {
            if !qa.units.isEmpty {
                // Split the unit list, returning the trimmed unit number
                let unitIds = qa.units.split(separator: "&")
                let trimmedUnitIds = unitIds.map() { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                unitList.formUnion(trimmedUnitIds)
            }
        }
        // We now have a set with unique unit ids.
        var unsortedUnits: [Unit] = []
        for unitId in unitList {
            if let unit = questionnaireData?.units.first(where: { $0.id == unitId}) {
                unsortedUnits.append(unit)
            }
        }

        // Add the units to the review
        review.units = unsortedUnits.sorted(by: {a, b in a.id < b.id})
        
        // Add the review to the start of the loaded reviews
        viewModel.reviews.insert(review, at: 0)
        
        // Save the review list
        viewModel.saveReviews()
    }
}


