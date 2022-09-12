// Project: Parse Questionnaire
//
//  Helper component for displaying MarkDown text.
//

import SwiftUI
import MarkdownUI

struct MarkdownView: View {
    
    var markdown: String
    
    var body: some View {
        VStack {
            Markdown(markdown)
                .markdownStyle(
                  MarkdownStyle(
                    font: .system(size: 15, design: .rounded),
                    measurements: .init(
                      codeFontScale: 0.8,
                      headingSpacing: 0.3
                    )
                  )
                )
        }
    }
    
    func markdownText(text: String) -> LocalizedStringKey {
        LocalizedStringKey(stringLiteral: text)
    }
}

struct MarkdownView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownView(markdown: "## Hello\n\n### Another Head\n\n* One\n* Two\n* Three\n\n World Steve")
    }
}
