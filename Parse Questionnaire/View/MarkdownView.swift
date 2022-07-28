// Project: Parse Questionnaire
//
//  
//

import SwiftUI
import MarkdownUI

struct MarkdownView: View {
    
    var markdown: String
    
    var body: some View {
        VStack {
            Markdown(markdown)
        }
    }
    
    func markdownText(text: String) -> LocalizedStringKey {
        LocalizedStringKey(stringLiteral: text)
    }
}

struct MarkdownView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownView(markdown: "## Hello\n\n* One\n* Two\n* Three\n\n World Steve")
    }
}
