// Project: Parse Questionnaire
//
//  The question and answer (and units list) card display. We get one of
//  these per question that the user asked. Its structured to have a fixed
//  height area at the top for the question, a banner for the answer
//  given and the list of units generated (or a placeholder).
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
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                        .background(Color.titleColor)
                        .font(.title3)
                        
                }
                .foregroundColor(Color.titleColor)
                
            }.background(Color.clear)
            
            if qa.units.count == 0 {
                noUnitsGenerated()
            } else {
                questoinUnits(qa)
            }

            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.secondary)
                .opacity(0.5)
        )
        .padding(15)
    }
    
    fileprivate func noUnitsGenerated() -> some View {
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
    }
    
    fileprivate func questoinUnits(_ qa: QandA) -> some View {
        // Return a list of the units in this question
        List(qa.unitText(unitText: units)) { datum in
            ResultUnitsCell(unit: datum)
        }.listStyle(.plain)
            
    }
}

struct ResultsQACard_Previews: PreviewProvider {
    static var previews: some View {
        ResultsQACard(qa: Review.dummyData.QA[0],
                      units: Review.dummyData.units)
        .preferredColorScheme(.dark)
    }
}
