//
//  ChatViewModel.swift
//  ChatGpt
//
//  Created by Süleyman Çambel on 18.08.2023.
//

import Foundation
extension ChatView {
    class ViewModel: ObservableObject {
        @Published var messages: [Message] = [Message(id: UUID(), role: .system, content: "Sor Dostum...", createAt: Date())]
        
        @Published var messageInput: String = ""
        
        private let openAiService = ChatService()
        
        func sendMessage() {
            let newMessage = Message(id: UUID(), role: .user, content: messageInput, createAt: Date())
            messages.append(newMessage)
            messageInput = ""
            openAiService.checkInternetConnection()
            Task {
                let response = await openAiService.sendMessage(messages: messages)
                guard let receivedAiMessage = response?.choices.first?.message else {
                    print("No Received")
                    openAiService.checkInternetConnection()
                    return
                }
                let receivedMessage = Message(id: UUID(), role: receivedAiMessage.role, content: receivedAiMessage.content, createAt: Date())
                await MainActor.run {
                    
                    messages.append(receivedMessage)

                }
            }
            
        }
    }
    
    
}
