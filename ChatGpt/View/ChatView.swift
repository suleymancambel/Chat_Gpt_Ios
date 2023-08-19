//
//  ContentView.swift
//  ChatGpt
//
//  Created by Süleyman Çambel on 18.08.2023.
//

import SwiftUI

struct ChatView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
           
            ScrollView {
                ForEach(viewModel.messages.filter({$0.role != .system}),
                        id: \.id) { message in
                            messageView(message: message)
                }
                
            }
            HStack {
                TextField("Yaz Dostum", text: $viewModel.messageInput)
                Button {
                    viewModel.sendMessage()
                    
                } label: {
                    Text("Send Dostum")
                }
            }
        }
        .padding()
    }
    
    func messageView(message: Message) -> some View {
        HStack {
        if message.role == .user {Spacer()}
        Text(message.content)
                .padding()
                .background(message.role == .user ? Color.blue.opacity(0.3) : Color.gray.opacity(0.3))
        if message.role == .assistant {Spacer()}
        }
    }
    
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
