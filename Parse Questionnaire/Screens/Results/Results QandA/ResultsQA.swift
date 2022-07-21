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
            Text("Questions and Answers")
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
