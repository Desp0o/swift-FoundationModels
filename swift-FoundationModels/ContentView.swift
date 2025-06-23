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
      ScrollView {
        VStack(alignment: .leading) {
          ForEach(vm.chat, id: \.id) { message in
            HStack {
              Text("You: ")
                .foregroundStyle(.pink)
                .fontWeight(.bold)
              Text(message.question)
              
              Spacer()
            }
            
            HStack(alignment: .top) {
              Text("AI: ")
                .fontWeight(.bold)
              Text(message.answer)
              
              Spacer()
            }
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      
      TextField("Ask Question", text: $vm.question)
        .frame(height: 40)
        .padding(.horizontal, 20)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .overlay {
          RoundedRectangle(cornerRadius: 22).stroke(lineWidth: 1)
        }
      
      Button {
        vm.askQuestion()
      } label: {
        Text("ASK")
      }
      .buttonStyle(.glass)
    }
    .animation(.default, value: vm.chat)
    .overlay {
      if vm.isLoading {
        VStack {
          ProgressView()
            .scaleEffect(2)
            .tint(.blue)
            .padding(20)
            .glassEffect(in: RoundedRectangle(cornerRadius: 10))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
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

struct ResponseModel: Equatable {
  let id = UUID()
  let question: String
  let answer: String
}
