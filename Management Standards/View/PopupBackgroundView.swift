// Project: Management Standards
//
//  Sets the colour of the background on popup windows.
//

import SwiftUI


struct PopupBackgroundView: View {
    var body: some View {
        Color.popupBackground
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        PopupBackgroundView()
            .preferredColorScheme(.dark)
    }
}
