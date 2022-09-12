// Project: Parse Questionnaire
//
//  Initialise an NSAttributedString with an HTML string.
//

import Foundation

extension NSAttributedString {

    convenience init(htmlString html: String) throws {
        try self.init(data: Data(html.utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil)
    }

}
