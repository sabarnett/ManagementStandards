// Project: Management Standards
//
//  
//

import SwiftUI

struct MessageBoxView: View {
    
    var message: MessageItem
    var onButtonPress: (MessageResponse) -> Void
    @State var isAnimating: Bool = false
        
    var body: some View {
        ZStack {
            VStack {
                titleText()
                
                messageBodyText()
                
                // If we have a dismiss button caption, then we want to show a single
                // button. If there is no caption, it is assumed that we want to display
                // two buttons. The colour of the buttons is set when they are defined.
                if message.dismissButton.caption.isEmpty {
                    doubleButton()
                } else {
                    singleButton()
                }
                
            }.padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.black.opacity(0.7))
                        .clipped()
                )
                .shadow(color: .white, radius: 1, x: 0, y: 0)
            
        }
        .opacity(isAnimating ? 1 : 0)
        .frame(maxWidth: 380)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.2)) {
                isAnimating = true
            }
        }
        .onDisappear {
            isAnimating = false
        }
    }

    fileprivate func titleText() -> some View {
        return VStack {
            Text(message.title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.titleColor)
            Divider()
        }
    }
    
    fileprivate func messageBodyText() -> some View {
        return VStack {
            Text(message.message).font(.subheadline).padding(.vertical, 20)
            Divider()
        }
    }
    
    fileprivate func doubleButton() -> some View {
        return HStack(alignment: .center) {
            Spacer()
            Button(action: {
                onButtonPress(.Primary)
            }, label: {
                APPButtonText(caption: message.primaryButton.caption,
                              buttonWidth: 120,
                              buttonHeight: 35,
                              backgroundColor: message.primaryButton.color,
                              foregroundColor: .primary)
            })
            Spacer()
            Divider()
            Spacer()
            Button(action: {
                onButtonPress(.Secondary)
            }, label: {
                APPButtonText(caption: message.secondaryButton.caption,
                              buttonWidth: 120,
                              buttonHeight: 35,
                              backgroundColor: message.secondaryButton.color,
                              foregroundColor: .primary)
            })
            Spacer()
        }.frame(maxHeight: 50)
    }
    
    fileprivate func singleButton() -> some View {
        return Button(action: {
            onButtonPress(.Dismiss)
        }, label: {
            APPButtonText(caption: message.dismissButton.caption,
                          buttonWidth: 180,
                          buttonHeight: 35,
                          backgroundColor: message.dismissButton.color)
        })
    }
}

struct MessageBoxView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MessageBoxView(message: MessageContext.userUpdated) {
                response in
                
                print(response)
            }.previewLayout(.sizeThatFits)
            
            MessageBoxView(message: MessageContext.confirmQuit) {
                response in
                
                print(response)
            }.previewLayout(.sizeThatFits)
        }
    }
}
