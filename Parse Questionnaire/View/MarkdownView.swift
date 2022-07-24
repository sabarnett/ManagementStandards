// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct MarkdownView: View {
    
    var markdown: String
    
    var body: Text {
        Text(markdownText(text: markdown))
    }
    
    func markdownText(text: String) -> LocalizedStringKey {
        LocalizedStringKey(stringLiteral: text)
    }
}

struct MarkdownView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownView(markdown: "**Hello** ~~World~~Steve")
    }
}
