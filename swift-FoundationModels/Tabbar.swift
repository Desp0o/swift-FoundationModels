//
//  Tabbar.swift
//  swift-FoundationModels
//
//  Created by Despo on 23.06.25.
//

import SwiftUI

struct Tabbar: View {
    var body: some View {
      TabView {
        Tab("Chat", systemImage: "ellipsis.message.fill") {
          ChatView()
        }
        
        Tab("Generate", systemImage: "gear") {
          GenerableView()
        }
      }
    }
}

#Preview {
    Tabbar()
}
