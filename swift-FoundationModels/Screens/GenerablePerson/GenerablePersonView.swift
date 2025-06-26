//
//  GenerablePersonView.swift
//  swift-FoundationModels
//
//  Created by Despo on 26.06.25.
//

import SwiftUI

struct GenerablePersonView: View {
  @State private var vm = GenerablePersonVM()
  
  var body: some View {
    VStack {
      Spacer()
      
      VStack(alignment: .leading) {
        if let person = vm.generatedPerson {
          Text("First Name: " + person.firstName)
          
          Text("Last Name: " + person.lastName)
          
          Text("Age: " + "\(person.age)")
          
          VStack(alignment: .leading) {
            Text("Hobbies: ")
              .fontWeight(.bold)
            
            ForEach(person.hobbies, id: \.self) {
              hobby in
              
              Text(hobby + ",")
            }
          }
        }
      }
      
      Spacer()
      
      VStack {
        TextField("Ask Question", text: $vm.prompt)
          .frame(height: 40)
          .padding(.horizontal, 20)
          .clipShape(RoundedRectangle(cornerRadius: 22))
          .overlay {
            RoundedRectangle(cornerRadius: 22).stroke(lineWidth: 1)
          }
        
        Button {
          vm.generate()
        } label: {
          Text("Generate")
        }
        .buttonStyle(.glass)
      }
    }
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
  }
}

#Preview {
  GenerablePersonView()
}


