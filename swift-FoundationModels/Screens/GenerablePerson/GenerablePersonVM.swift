//
//  GenerablePersonVM.swift
//  swift-FoundationModels
//
//  Created by Despo on 26.06.25.
//

import FoundationModels
import Observation

@MainActor
@Observable

final class GenerablePersonVM {
  var prompt: String = ""
  var isLoading: Bool = false
  var generatedPerson: Person? = nil
  
  func generate() {
    let session = LanguageModelSession()
    isLoading = true
    
    Task {
      defer {
        isLoading = false
      }
      
      do {
        let response = try await session.respond(to: prompt, generating: Person.self)
        
        generatedPerson = response.content
      } catch {
        print(error)
      }
    }
  }
}

@Generable(description: "basic info about person")
struct Person {
  let firstName: String
  let lastName: String
  
  @Guide(description: "person age is in number", .range(21...45))
  let age: Int
  
  @Guide(description: "person hobbies", .count(10))
  let hobbies: [String]
}
