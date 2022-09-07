// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct MessageBoxViewModifier: ViewModifier {
    
    @Binding var message: MessageItem?
    var buttonPressed: ((MessageResponse) -> Void)? = nil
    
    init(message: Binding<MessageItem?>, onButtonPress: ((MessageResponse) -> Void)? = nil) {
        self._message = message
        self.buttonPressed = onButtonPress
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: message != nil ? 15 : 0)
            
            if let messageItem = message {
                MessageBoxView(message: messageItem) {
                    response in
                    
                    message = nil
                    if let buttonPressed = buttonPressed {
                        buttonPressed(response)
                    }
                }.padding(.horizontal, 10)
            }
        }
    }
}

extension View {
    func messageBox(message: Binding<MessageItem?>, onButtonPress: ((MessageResponse) -> Void)? = nil) -> some View {
        self.modifier(MessageBoxViewModifier(message: message, onButtonPress: onButtonPress))
    }
}
