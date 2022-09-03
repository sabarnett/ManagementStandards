// Project: Parse Questionnaire
//
//  
//

import SwiftUI

struct MessageBoxViewModifier: ViewModifier {
    
    @Binding var message: MessageItem?
    
    init(message: Binding<MessageItem?>) {
        self._message = message
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: message != nil ? 15 : 0)
            
            if message != nil {
                ZStack {
                    VStack {
                        Text(message!.title).font(.title2).fontWeight(.semibold)
                        Divider()
                        
                        Text(message!.message).font(.subheadline)
                        Divider()

                        Button(action: {
                            message = nil
                        }, label: {
                            APPButtonText(caption: message!.dismissButton, buttonWidth: 180, buttonHeight: 35)
                        })
                    }.padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.black.opacity(0.8))
                                .shadow(color: .white, radius: 1, x: 0, y: 0)
                                .clipped()
                        )

                }.padding(40)
            }
        }
    }
}

extension View {
    func messageBox(message: Binding<MessageItem?>) -> some View {
        self.modifier(MessageBoxViewModifier(message: message))
    }
}
