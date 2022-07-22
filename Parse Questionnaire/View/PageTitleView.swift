// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct PageTitleView: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(Color.titleColor)
                .padding(15)
            Spacer()
        }
    }
}

struct PageTitleView_Previews: PreviewProvider {
    static var previews: some View {
        PageTitleView(title: "Hello World")
    }
}
