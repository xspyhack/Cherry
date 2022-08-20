//
//  NavigationStore.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/20.
//

import SwiftUI
import Blessing

final class Coordinator: ObservableObject {
  @Published var path: [Matter.ID] = []

  func push(to matter: Matter) {
    path.append(matter.id)
  }

  func popToRoot() {
    path.removeAll()
  }
}

extension Coordinator {
  static let preview = Coordinator()
}
