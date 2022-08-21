// Report builder. Rakes a review and builds the complete report in Markdown format.

import Foundation

struct ReviewReportBuilder {
    
    // MARK:- Public interface
    
    /// Builds a report for a review instance. This will be a complete review in Markdown format.
    ///
    /// - Parameter review: The review to be reported on.
    ///
    /// - Returns: The complete report in Markdown format.
    ///
    func buildReport(for review: Review) -> String {
        
        let reportHeader = buildReportHeader(review)
        let unitText = buildUnitText(review)
        
        let qaHeader = buildQAHeader(review)
        let qaAnalysis = buildQAAnalysis(review)
        
        return "\(reportHeader)\n\n\(unitText)\n\n\(qaHeader)\n\n\(qaAnalysis)"
    }
    
    // MARK:- Helper functions - build each section
    
    fileprivate func buildReportHeader(_ review: Review) -> String {
        
        var reportHeader = "# \(review.title)\n\n\(review.description)"
        
        guard let user = Users.shared.loggedInUser else { return reportHeader }
        guard let firstname = user.firstname,
              let lastname = user.lastname,
              let email = user.email else { return reportHeader }
        
        reportHeader = reportHeader +
        "\n\nThis report has been prepared for \(firstname) \(lastname) from the review created on \(review.createdDateFormatted). They can be contacted via \(email)"

        if let reportIntro = review.reportIntro {
            reportHeader = reportHeader + "\n\n\(reportIntro)"
        }

        return reportHeader
    }
    
    fileprivate func buildUnitText(_ review: Review) -> String {
        review.units.map({ $0.analysisText }).joined(separator: "\n\n")
    }
    
    fileprivate func buildQAHeader(_ review: Review) -> String {
        var qaHeader = ""
        
        if let qaHeaderIntro = review.qaIntro {
            qaHeader = qaHeader + qaHeaderIntro
        } else {
            qaHeader = qaHeader + "# Question/Unit Analysis"
        }
        return qaHeader
    }

    fileprivate func buildQAAnalysis(_ review: Review) -> String {
        var analysis = ""
        
        for qa in review.QA {
            analysis = analysis + "\n\n**\(qa.id). \(qa.question)**\n\n"
            analysis = analysis + "Answer **\(qa.answer)**\n\n"
            analysis = analysis + "Units added: \(qa.units.count > 0 ? qa.units : "None added.")"
        }

        return analysis
    }
}
