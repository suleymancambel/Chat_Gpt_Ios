//
//  ChatModel.swift
//  ChatGpt
//
//  Created by Süleyman Çambel on 18.08.2023.
//

import Foundation


struct Message: Decodable {
    let id: UUID
    let role: SenderRole
    let content: String
    let createAt: Date
}

struct OpenAiChatBody: Encodable {
    let model: String
    let messages: [OpenAiChatMessage]
}

struct OpenAiChatMessage: Codable {
    let role: SenderRole
    let content: String
}

enum SenderRole: String, Codable{
    case system
    case user
    case assistant
}

struct OpenAiChatResponse: Decodable {
    let choices: [OpenAiChatChoice]
}

struct OpenAiChatChoice: Decodable {
    let message: OpenAiChatMessage
}
