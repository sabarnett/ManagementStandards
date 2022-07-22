// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct ResultsQACard: View {
    
    @State var qa: QandA
    var units: [Unit]
    
    var body: some View {
        VStack(alignment: .leading) {
            ResultTitle(titleText: "Question")
            
            Text(qa.question)
                .font(.body)
                .fontWeight(.semibold)
                .padding(.bottom, 20)

            ResultTitle(titleText: "Your Answer")

            Text(qa.answer)
                .font(.body)
                .fontWeight(.semibold)
                .padding(.bottom, 20)

            ResultTitle(titleText: "Selected Units")

            List(qa.unitText(unitText: units)) { datum in
                ResultUnitsCell(unit: datum)
            }.listStyle(.plain)
            Spacer()
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.secondary)
                .opacity(0.3)
        )
        .padding(15)
    }
}

struct ResultTitle: View {
    
    var titleText: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(titleText)
                    .padding(.bottom, -2)
                    .font(.title3)
                Rectangle()
                    .frame(height: 1)
            }
            .foregroundColor(Color.titleColor)
            Spacer()
        }
    }
}

struct ResultsQACard_Previews: PreviewProvider {
    static var previews: some View {
        ResultsQACard(qa: Review.dummyData.QA[0],
                      units: Review.dummyData.units)
    }
}
