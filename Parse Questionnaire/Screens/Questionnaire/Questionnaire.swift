// Project: Parse Questionnaire
//
//  
//

import Foundation

class Questionnaire: ObservableObject {
    
    @Published var questionnaireData: QuestionnaireData? = QuestionnaireLoader.load(forName: "ManagementStandards")
    @Published var isComplete: Bool = false
    @Published var messageItem: MessageItem?
    
    private var currentQuestionId = 1
    private var review: Review = Reviews.shared.newReview()
    
    var currentQuestion: Question {
        guard let data = questionnaireData else { return Question.empty }
        return data.question(withId: currentQuestionId)
    }
    
    /// Saves the answer that was gien in response to the current question. Depending on the answer given, we may add
    /// to the list of units that we are keeping track of. Each answer option may have zero, one or more units associated
    /// with it.
    ///
    /// - Parameter buttonPress: The button that was pressed when the question was presented. There are three
    ///         options available; Yes, No or Maybe.
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
        
        isComplete = currentQuestion.targetIfNo == -1
            && currentQuestion.targetIfYes == -1
            && currentQuestion.targetIfUnsure == -1
        
        objectWillChange.send()
    }
    
    /// Save the review to the database.
    ///
    /// At the point this is called, we have a list of the questions asked, the answers given and the units that were
    /// generated as a consequence. This method fills out the questionnaire instance by working out a unique list
    /// of units and storing the unit data in the review file. This ensures that, should the review file be changed, we
    /// have stored the state of the review at the point it was generated.
    ///
    /// - Parameter viewModel: The global view model - this is used as  the vehicle for saving the review.
    ///
    func saveReview(to viewModel: AppData) {
        guard let qData = questionnaireData else { fatalError("Attempt to save a review that was not created.") }
        
        // Add intro text to the review so we have it for reporting
        review.reportIntro = qData.reportIntroduction
        review.qaIntro = qData.questionsIntroduction
        
        // Resolve the unit list into a set containing unique units numbers trimmed of all whitespace
        var unitList: Set<String> = Set<String>()
        for qa in review.QA {
            if !qa.units.isEmpty {
                let unitIds = qa.units.components(separatedBy: CharacterSet(charactersIn: "&,"))

                let trimmedUnitIds = unitIds.map() { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                unitList.formUnion(trimmedUnitIds)
            }
        }
        
        // We now have a set with unique unit ids. Translate this into a list of full units.
        let unsortedUnits: [Unit] = unitList.map() { unitId in
            qData.units.first(where: { $0.id == unitId})!
        }

        // Add the units to the review
        review.units = unsortedUnits.sorted(by: {a, b in a.sortKey < b.sortKey })
        
        // Add the review which will also cause the list to save
        viewModel.addReview(review)
        viewModel.selectedReview = review
        viewModel.showReview = true
    }
    
    var reviewTitle: String {
        get { review.title }
        set {
            if newValue.isEmpty {
                messageItem = MessageContext.reviewTitleRequired
                return
            }
            review.title = newValue
        }
    }
    
    var reviewDescription: String {
        get { review.title }
        set {
            if newValue.isEmpty {
                messageItem = MessageContext.reviewDescriptionRequired
                return
            }
            review.description = newValue
        }
    }
}
