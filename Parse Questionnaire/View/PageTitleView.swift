// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct PageTitleView: View {
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
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .padding()
        }
    }
}

struct PageTitle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PageTitleView()
                .previewLayout(.sizeThatFits)
            PageTitleView()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
