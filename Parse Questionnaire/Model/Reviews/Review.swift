// Project: Parse Questionnaire
//
//  
//

import Foundation
import UIKit
import MarkdownUI

struct ReviewList: Codable {
    var reviews: [Review]
}

struct Review: Codable, Identifiable {
    
    // MARK:- Review Persistable properties.
    
    var id: UUID = UUID()
    var created: Date
    var title: String
    var description: String
    var QA: [QandA]
    var units: [Unit]

    // MARK:- Review Computed properties
    
    var unitCount: Int { units.count }
    
    var questionCount: Int { QA.count }
    
    var createdDateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM y - HH:mm "
        return formatter.string(from: created)
    }

    var report: String {
        get {
            let unitText = self.units.map({ $0.analysisText })
            return unitText.joined(separator: "\n\n")
        }
    }
}

extension Review {

    // MARK:- Share icon handler

    func shareReview() {
        let reportData = try! Document(markdown: self.report).renderHTML()
        let htmlData = "<h1>\(self.title)</h1><p>\(self.description)</p>\(reportData)"
        
        let attributedString = try? NSAttributedString(htmlString: htmlData)
        let pdfData = HTMLtoPDF.toPDF(htmlData)
        
        let av = UIActivityViewController(activityItems: [attributedString!, pdfData],
                                          applicationActivities: nil)
        
        let scenes = UIApplication.shared.connectedScenes
        guard
            let windowScenes = scenes.first as? UIWindowScene,
            let window = windowScenes.windows.first,
            let rootView = window.rootViewController
        else { return }
        
        rootView.present(av, animated: true, completion: nil)
    }
}

