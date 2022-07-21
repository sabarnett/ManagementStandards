// Project: Parse Questionnaire
//
//  
//

import SwiftUI


struct BackgroundView: View {
    var body: some View {
        LinearGradient(
            colors: [Color.backgroundStart, Color.backgroundEnd],
            startPoint: .top, endPoint: .bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
