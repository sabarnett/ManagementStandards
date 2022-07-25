// Project: Parse Questionnaire
//
//  
//

import SwiftUI


struct PopupBackgroundView: View {
    var body: some View {
        Color.secondary.opacity(0.8)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        PopupBackgroundView()
    }
}
