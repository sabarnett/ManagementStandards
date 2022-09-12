// Project: Parse Questionnaire
//
//  Provides a title at the top of the page and optionally provides a
//  sub-title below it in a considerably smaller font size.
//

import SwiftUI

struct PageTitleView: View {
    
    var title: String
    var subtitle: String?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.titleColor)
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.titleColor)
                }
            }.padding(15)
            Spacer()
        }
    }
}

struct PageTitleView_Previews: PreviewProvider {
    static var previews: some View {
        PageTitleView(title: "Hello World",
                      subtitle: "user name")
    }
}
