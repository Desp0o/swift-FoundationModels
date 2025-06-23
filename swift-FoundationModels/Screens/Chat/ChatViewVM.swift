//
//  ChatViewModel.swift
//  swift-FoundationModels
//
//  Created by Despo on 23.06.25.
//

import FoundationModels
import Playgrounds
import Observation
import Foundation

struct ResponseModel: Equatable {
  let id = UUID()
  let question: String
  let answer: String
}

@MainActor
@Observable
final class ChatViewModel {
  var chat: [ResponseModel] = []
  var question: String = ""
  var isLoading: Bool = false
  
  func askQuestion() {
    let session = LanguageModelSession()
    isLoading = true
    
    Task {
      defer {
        isLoading = false
      }
      
      do {
        let response = try await session.respond(to: question)
        let model = ResponseModel(question: question, answer: response.content)
        question = ""
        chat.append(model)
      } catch {
        print(error)
      }
    }
  }
}
