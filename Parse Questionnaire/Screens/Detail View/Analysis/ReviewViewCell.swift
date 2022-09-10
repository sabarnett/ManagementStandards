// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct ReviewViewCell: View {
    
    @State var review: Review
    
    var body: some View {
       HStack {
            Text("\(review.unitCount)")
                .fontWeight(.bold)
                .frame(width: 45, height: 45, alignment: .center)
                .border(.clear, width: 50)
                .background(Color.buttonBackground)
                .foregroundColor(Color.buttonForeground)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            VStack(alignment: .leading) {
                Text(review.title)
                    .font(.body)
                    .fontWeight(.semibold)
                Text(review.createdDateFormatted)
                    .font(.footnote)
            }
           
//           Spacer()
//           Button(action: {}) {
//               Image(systemName: "chevron.right")
//           }
        }.padding(6)
    }
}

struct AnalysisViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ReviewViewCell(review: Review.dummyData)
            .previewLayout(.sizeThatFits)
    }
}
