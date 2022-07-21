// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct ResultsQA: View {

    @State var review: Review
    @State var appearAnimationActive:Bool = false

    var body: some View {
        VStack {
            TabView {
                ForEach(review.QA) { q in
                    ResultsQACard(qa: q, units: review.units)
                }
            }.tabViewStyle(.page)
        }
        .opacity(appearAnimationActive ? 1 : 0.1)
        .onAppear {
            withAnimation(.easeIn(duration: 0.4)) {
                appearAnimationActive = true
            }
        }
        .onDisappear {
            appearAnimationActive = false
        }
    }
}

struct ResultsQA_Previews: PreviewProvider {
    static var previews: some View {
        ResultsQA(review: Review.dummyData)
    }
}
