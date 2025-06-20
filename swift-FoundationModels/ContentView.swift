//
//  ContentView.swift
//  swift-FoundationModels
//
//  Created by Despo on 19.06.25.
//
import FoundationModels
import SwiftUI
import Playgrounds

struct ContentView: View {
  @State private var vm = ContentViewModel()
  @State private var question: String = ""
  var body: some View {
    VStack {
      TextField("Ask Question", text: $question)
        .frame(height: 40)
        .padding(.horizontal, 20)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .overlay {
          RoundedRectangle(cornerRadius: 22).stroke(lineWidth: 1)
        }
      
      Button {
        vm.askQuestion(question: question)
      } label: {
        Text("ASK")
      }
      .buttonStyle(.glass)
      
      Text(vm.answer)
    }
    .padding()
  }
}

#Preview {
  ContentView()
}

import Observation

@MainActor
@Observable
final class ContentViewModel {
  var answer: String = ""
  
  func askQuestion(question: String) {
    let session = LanguageModelSession()
    
    Task {
      do {
        let response = try await session.respond(to: question)
        answer = response.content
      } catch {
        print(error)
      }
    }
  }
}
