// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct AnalysisViewCell: View {
    
    @State var review: Review
    
    var body: some View {
        HStack {
            Text("\(review.unitCount)")
                .fontWeight(.bold)
                .frame(width: 50, height: 50, alignment: .center)
                .border(.clear, width: 50)
                .background(Color.buttonBackground)
                .foregroundColor(Color.buttonForeground)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(review.title)
                    .font(.body)
                    .fontWeight(.semibold)
                Text(review.createdDateFormatted)
                    .font(.footnote)

            }
        }.padding(6)
    }
}

struct AnalysisViewCell_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisViewCell(review: Review.dummyData)
            .previewLayout(.sizeThatFits)
    }
}
