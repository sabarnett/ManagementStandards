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
                .fullScreenCover(item: $message) {
                    messageItem in
                    
                    ZStack {
                        MessageBoxView(message: messageItem) {
                            response in
                            
                            message = nil
                            if let buttonPressed = buttonPressed {
                                buttonPressed(response)
                            }
                        }.padding(.horizontal, 10)
                    }.background(FullScreenCoverBackgroundRemovalView())
                }
        }
    }
}

private struct FullScreenCoverBackgroundRemovalView: UIViewRepresentable {
    
    private class BackgroundRemovalView: UIView {
        override func didMoveToWindow() {
            super.didMoveToWindow()
            
            superview?.superview?.backgroundColor = .clear
        }
    }
    
    func makeUIView(context: Context) -> UIView {
        return BackgroundRemovalView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
    
}

extension View {
    func messageBox(message: Binding<MessageItem?>, onButtonPress: ((MessageResponse) -> Void)? = nil) -> some View {
        self.modifier(MessageBoxViewModifier(message: message, onButtonPress: onButtonPress))
    }
}
