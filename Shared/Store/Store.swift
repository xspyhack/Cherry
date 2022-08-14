//
//  Store.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/14.
//

import Foundation
import SwiftUI
import Blessing

@MainActor
final class Store: ObservableObject {
  @Published var matters: [Matter] = []

  private let service = MatterService()

  init() {
    Task(priority: .background) {
      let bootstrap = Bootstrap()
      bootstrap.start()

      let matters = await service.loadAll()

      Task { @MainActor in
        withAnimation(.spring(response: 0.4, dampingFraction: 1)) {
          self.matters.append(contentsOf: matters)
        }
      }
    }
  }

  func matter(for id: Matter.ID) -> Matter {
    guard let index = matters.firstIndex(where: { $0.id == id }) else {
      fatalError()
    }
    return matters[index]
  }

  func matterBinding(for id: Matter.ID) -> Binding<Matter> {
    Binding<Matter> {
      guard let index = self.matters.firstIndex(where: { $0.id == id }) else {
        fatalError()
      }
      return self.matters[index]
    } set: { newValue in
      guard let index = self.matters.firstIndex(where: { $0.id == id }) else {
        fatalError()
      }
      return self.matters[index] = newValue
    }
  }
}

extension Store {
  static let preview = Store()
}
