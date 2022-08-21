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
                Text(qa.question)
                    .font(.body)
                    .padding(10)
                    .foregroundColor(.secondary)
                    .frame(minHeight: 110)
                
                VStack(alignment: .center) {
                    Text("Your answer: \(qa.answer)")
                        .frame(maxWidth: .infinity)
                        .background(Color.titleColor)
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                        .font(.title3)
                        
                }
                .foregroundColor(Color.titleColor)
            }.background(Color.secondary.opacity(0.3))
            
            questoinUnits(qa)

            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.secondary)
                .opacity(0.3)
        )
        .padding(15)
    }
    
    fileprivate func questoinUnits(_ qa: QandA) -> AnyView {
        
        if qa.units.count == 0 {
            // There are no units, so display the placeholder
            return AnyView(
                HStack {
                    Spacer()
                    VStack {
                        Image("StarPages")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250, height: 200)
                            .opacity(0.3)
                        Text("No Units Generated")
                            .font(.title2)
                    }
                    Spacer()
                }
            )
        } else {
            // Return a list of the units in this question
            return AnyView(
                List(qa.unitText(unitText: units)) { datum in
                    ResultUnitsCell(unit: datum)
                }.listStyle(.plain)
                    .padding(15)
                )
        }
    }
}

struct ResultsQACard_Previews: PreviewProvider {
    static var previews: some View {
        ResultsQACard(qa: Review.dummyData.QA[0],
                      units: Review.dummyData.units)
        .preferredColorScheme(.dark)
    }
}
