// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct QuestionnaireTitleView: View {
    var body: some View {
        HStack {
            Image("TickCross")
                .resizable()
                .frame(width: 60, height: 70, alignment: .center)
            Text("Management\nStandards")
                .font(.system(size: 28,
                              weight: .bold,
                              design: .default))
                .italic()
                .foregroundColor(.titleColor)
                .multilineTextAlignment(.leading)
                .padding()
        }
    }
}

struct PageTitle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QuestionnaireTitleView()
                .previewLayout(.sizeThatFits)
            QuestionnaireTitleView()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
