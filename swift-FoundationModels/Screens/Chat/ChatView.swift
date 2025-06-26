//
//  ContentView.swift
//  swift-FoundationModels
//
//  Created by Despo on 19.06.25.
//

import SwiftUI

struct ChatView: View {
  @State private var vm = ChatViewModel()
  @State private var question: String = ""
  @State private var animationsRunning = false
  
  var body: some View {
    VStack {
      
      if vm.chat.isEmpty {
        VStack {
          Spacer()
          
          Image(systemName: "8.circle.fill")
            .resizable()
            .frame(width: 48, height: 48)
            .symbolEffect(.bounce, options: .repeat(.continuous).speed(0.3), value: animationsRunning)
            .onAppear {
              animationsRunning.toggle()
            }
          
          Text("Ask me anything")
            .fontWeight(.bold)
          
          Spacer()
        }
      } else {
        ScrollView {
          VStack(alignment: .leading) {
            ForEach(vm.chat, id: \.id) { message in
              HStack {
                Text("You: ")
                  .foregroundStyle(.black)
                  .fontWeight(.bold)
                Text(message.question)
                
                Spacer()
              }
              
              HStack(alignment: .top) {
                Text("AI: ")
                  .foregroundStyle(.black)
                  .fontWeight(.bold)
                Text(message.answer)
                
                Spacer()
              }
              
              Spacer()
                .frame(height: 20)
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
        .scrollIndicators(.hidden)
        .symbolEffect(.bounce, options: .speed(3).repeat(3), isActive: true)
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
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding()
    .background(.indigo.gradient)
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
    .animation(.default, value: vm.chat)
  }
}

#Preview {
  ChatView()
}



