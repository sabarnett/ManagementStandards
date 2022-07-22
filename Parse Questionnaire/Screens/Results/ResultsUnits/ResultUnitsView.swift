// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct ResultUnitsView: View {
    
    @State var review: Review
    @State var appearAnimationActive:Bool = false
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(review.title)
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text(review.createdDateFormatted)
                        .font(.caption)
                }
                .foregroundColor(Color.titleColor)
                .padding(.horizontal, 15)
                Spacer()
            }
            
            if review.unitCount == 0 {
                Spacer()
                
                Image("StarPages")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 280, alignment: .center)
                Text("Your answers did not result in the selection of any units. You should run the review again.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .font(.body)
                    .foregroundColor(.secondary)
                
                Spacer()
            } else {
                VStack(alignment: .leading) {
                    Text(review.description)
                        .font(.subheadline)
                        .padding(15)

                    List(review.units) { datum in
                        ResultUnitsCell(unit: datum)
                    }.listStyle(.plain)
                }
            }
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

struct ResultUnitsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultUnitsView(review: Review.dummyData)
    }
}
