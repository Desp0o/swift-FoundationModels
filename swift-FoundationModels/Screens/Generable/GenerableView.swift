//
//  GenerableView.swift
//  swift-FoundationModels
//
//  Created by Despo on 25.06.25.
//

import SwiftUI

struct GenerableView: View {
  @State private var vm = GenerableVM()
  
  var body: some View {
    VStack {
      List(vm.productList.indices, id: \.self) { index in
        HStack {
          Text(vm.productList[index])
          Spacer()
          if vm.selectedIndexs.contains(index) {
            Text("✅")
          }
        }
        .contentShape(Rectangle())
        .onTapGesture {
          vm.saveSelectedIndex(index: index)
          vm.saveIngredients(ingredient: vm.productList[index])
        }
      }
      .scrollContentBackground(.hidden)
      
      ScrollView {
        VStack {
          Button("Generate") {
            vm.generateRecipe()
          }
          .buttonStyle(.glass)
          
          if let recipe = vm.recipe {
            Text(recipe.recipe)
              .foregroundStyle(.white)
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(20)
      }
      .scrollIndicators(.hidden)
    }
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
  GenerableView()
}



