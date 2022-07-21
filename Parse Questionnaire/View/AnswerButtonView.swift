// Project: Parse Questionnaire
//
//  
//

import SwiftUI

enum ButtonPress {
    case yes
    case no
    case unsure
}

struct AnswerButtonsView: View {
    
    let action: (_: ButtonPress) -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                action(.yes)
            }, label: {
                APPButtonText(caption: "Yes")
            })
                
            Button(action: {
                action(.no)
            }, label: {
                APPButtonText(caption: "No")
            })

            Button(action: {
                action(.unsure)
            }, label: {
                APPButtonText(caption: "Unsure")
            })
        }
        .padding()
    }
}



struct AnswerButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AnswerButtonsView(action: {
                button in
                print("\(button) pressed")
            })
            .previewLayout(.sizeThatFits)
            AnswerButtonsView(action: {
                button in
                print("\(button) pressed")
            })
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
        }
    }
}
