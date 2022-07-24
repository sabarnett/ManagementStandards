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
            VStack(alignment: .leading) {
                VStack(alignment: .center) {
                    Text("Question \(qa.id)")
                        .padding(.bottom, -2)
                        .padding(.top, 5)
                        .font(.title3)
                    Rectangle()
                        .frame(height: 1)
                }
                .foregroundColor(Color.titleColor)
                
                Text(qa.question)
                    .font(.body)
                    .padding(10)
                    .foregroundColor(.secondary)
                
                VStack(alignment: .center) {
                    Rectangle()
                        .frame(height: 1)
                    Text("Answer: \(qa.answer)")
                        .padding(.top, -2)
                        .padding(.bottom, 5)
                        .font(.title3)
                }
                .foregroundColor(Color.titleColor)
            }.background(Color.secondary.opacity(0.3))
            
            List(qa.unitText(unitText: units)) { datum in
                ResultUnitsCell(unit: datum)
            }.listStyle(.plain)
                .padding(15)
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.secondary)
                .opacity(0.3)
        )
        .padding(15)
    }
}

struct ResultsQACard_Previews: PreviewProvider {
    static var previews: some View {
        ResultsQACard(qa: Review.dummyData.QA[0],
                      units: Review.dummyData.units)
        .preferredColorScheme(.dark)
    }
}
