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
            
            if message != nil {
                ZStack {
                    VStack {
                        Text(message!.title).font(.title2).fontWeight(.semibold)
                            .foregroundColor(.titleColor)
                        Divider()
                        
                        Text(message!.message).font(.subheadline)
                        Divider()
                        
                        if message!.dismissButton.caption.isEmpty {
                            HStack(alignment: .center, spacing: 20) {
                                Button(action: {
                                    message = nil
                                    if let onButtonPress = buttonPressed { onButtonPress(.Primary) }
                                }, label: {
                                    APPButtonText(caption: message!.primaryButton.caption,
                                                  buttonWidth: 120,
                                                  buttonHeight: 35,
                                                  backgroundColor: message!.primaryButton.color,
                                                  foregroundColor: .primary)
                                })
                                Button(action: {
                                    message = nil
                                    if let onButtonPress = buttonPressed { onButtonPress(.Secondary) }
                                }, label: {
                                    APPButtonText(caption: message!.secondaryButton.caption,
                                                  buttonWidth: 120,
                                                  buttonHeight: 35,
                                                  backgroundColor: message!.secondaryButton.color,
                                                  foregroundColor: .primary)
                                })
                            }
                        } else {
                            Button(action: {
                                message = nil
                                if let onButtonPress = buttonPressed { onButtonPress(.Dismiss) }
                            }, label: {
                                APPButtonText(caption: message!.dismissButton.caption,
                                              buttonWidth: 180,
                                              buttonHeight: 35,
                                              backgroundColor: message!.dismissButton.color)
                            })
                        }
                        
                    }.padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.black.opacity(0.8))
                                .clipped()
                        )
                        .shadow(color: .white, radius: 1, x: 0, y: 0)
                    
                }.padding(40)
                    .frame(maxWidth: 380)
            }
        }
    }
    
}

extension View {
    func messageBox(message: Binding<MessageItem?>, onButtonPress: ((MessageResponse) -> Void)? = nil) -> some View {
        self.modifier(MessageBoxViewModifier(message: message, onButtonPress: onButtonPress))
    }
}
