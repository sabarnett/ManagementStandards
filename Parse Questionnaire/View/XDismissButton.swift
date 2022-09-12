//
// Used in popup windows to provide a dismiss button. The styling allows us to
// create the button content. The code to then put it on the form is separate
// and part of a ZStack
//

import SwiftUI

struct XDismissButton: View {

    var body: some View {
        Image(systemName: "x.circle.fill")
            .font(Font.body.weight(.bold))
            .foregroundColor(.secondary)
            .frame(width: 44, height: 44)
            .scaleEffect(1.5)
    }
}

struct XDismissButton_Previews: PreviewProvider {
    static var previews: some View {
        XDismissButton()
    }
}
