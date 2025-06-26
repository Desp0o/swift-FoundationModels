//
//  GenerableVM.swift
//  swift-FoundationModels
//
//  Created by Despo on 26.06.25.
//

import Observation
import FoundationModels

@Generable(description: "generate a recipe with given ingerdients")
struct Recipe {
  let recipe: String
}

@MainActor
@Observable
final class GenerableVM {
  var selectedIngredients: [String] = []
  var selectedIndexs: [Int] = []
  var recipe: Recipe? = nil
  var isLoading: Bool = false
  
  let productList: [String] = [
      "Tomato",
      "Cucumber",
      "Burrata Cheese",
      "Egg",
      "Avocado",
      "Lemongrass",
  ]
  
  func saveSelectedIndex(index: Int) {
    if selectedIndexs.contains(index) {
      let foundIndex = selectedIndexs.firstIndex { $0 == index }
      guard let foundIndex else { return }
      selectedIndexs.remove(at: foundIndex)
    } else {
      selectedIndexs.append(index)
    }
  }
  
  func saveIngredients(ingredient: String) {
    if selectedIngredients.contains(ingredient) {
      selectedIngredients.removeAll { $0 == ingredient }
    } else {
      selectedIngredients.append(ingredient)
    }
  }
  
  func generateRecipe() {
    let session = LanguageModelSession()
    isLoading = true
    
    Task {
      defer {
        isLoading = false
      }
      
      do {
        let prompt = "Generate a recipe with given ingredients \(selectedIngredients)"

        let generatedRecipe = try await session.respond(to: prompt, generating: Recipe.self)
        
        recipe = generatedRecipe.content
      } catch {
        print("❌", error)
      }
    }
  }
}
