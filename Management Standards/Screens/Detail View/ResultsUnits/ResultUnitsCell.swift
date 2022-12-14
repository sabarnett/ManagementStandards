// Project: Management Standards
//
//  Displays the unit cell consisting of the unit number and the title.
//

import SwiftUI

struct ResultUnitsCell: View {
    
    @State var unit: Unit
    @State var showUnit: Bool = false
    
    var body: some View {
        HStack {
            Text(unit.id)
                .fontWeight(.bold)
                .frame(width: 50, height: 50, alignment: .center)
                .border(.clear, width: 50)
                .background(Color.buttonBackground)
                .foregroundColor(Color.buttonForeground)
                .clipShape(RoundedRectangle(cornerRadius: 15))

                Text(unit.title)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            
            Spacer()
            Button(action: {}) {
                Image(systemName: "chevron.right")
            }
        }
        .onTapGesture {
            showUnit = true
        }
        .sheet(isPresented: $showUnit) {
            UnitView(unit: unit, sheetShown: $showUnit)
        }

    }
}

struct ResultsCell_Previews: PreviewProvider {
    static var previews: some View {
        ResultUnitsCell(unit: Unit.dummyData)
            .previewLayout(.sizeThatFits)
    }
}
