//
//  ChatService.swift
//  ChatGpt
//
//  Created by Süleyman Çambel on 18.08.2023.
//

import Foundation
import Alamofire


class ChatService {
    private let endpoint = Constant.OpenAiApiUrl
    func sendMessage(messages: [Message]) async -> OpenAiChatResponse? {
        
        
        let chatmessage = messages.map({OpenAiChatMessage(role: $0.role, content: $0.content) })
        
        let body = OpenAiChatBody(model: "gpt-3.5-turbo", messages: chatmessage)
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constant.OpenAiApiKey)"
        ]
        
        return try? await AF.request(endpoint, method: .post, parameters: body, encoder: .json , headers: headers).serializingDecodable(OpenAiChatResponse.self).value
        
        
        
    }
    func checkInternetConnection() {
        let url = URL(string: "https://www.google.com")!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Internet bağlantısı yok: \(error.localizedDescription)")
            } else {
                print("İnternet bağlantısı var.")
            }
        }
        task.resume()
    }
}
