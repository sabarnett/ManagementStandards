// Project: Management Standards
//
//  Defines the content and functionality of a review.This data is loaded from the
//  user specific review data file.
//

import Foundation
import UIKit
import MarkdownUI

struct ReviewList: Codable {
    var reviews: [Review]
}

struct Review: Codable, Identifiable {
    
    // MARK: - Review Persistable properties.
    
    var id: UUID = UUID()
    var created: Date
    var title: String
    var description: String
    var QA: [QandA]
    var units: [Unit]
    var reportIntro: String?
    var qaIntro: String?
}

extension Review {
    
    // MARK: - Review Computed properties
    
    var unitCount: Int { units.count }
    
    var questionCount: Int { QA.count }
    
    var createdDateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM y - HH:mm "
        return formatter.string(from: created)
    }

    var report: String {
        get {
            let reportData = ReviewReportBuilder().buildReport(for: self)
            return reportData
        }
    }
}

extension Review {

    // MARK: - Share icon data. We return an array of data to be passed to the share handler

    func reportShareItems() -> [Any] {
        let markdown = self.report
        let markdownDocument = try! Document(markdown: markdown)
        
        let reportData = markdownDocument.renderCommonMark()
        let htmlData = markdownDocument.renderHTML()

        let attributedString = try? NSAttributedString(htmlString: htmlData)
        let pdfData = HTMLtoPDF.toPDF(htmlData)
        
        // Formats supported:
        // 1. Attributed String
        // 2. PDF
        // 3. CommonMark markdown
        return [attributedString!, pdfData, reportData]
    }
}

