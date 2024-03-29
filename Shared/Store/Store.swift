//
//  Store.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/14.
//

import Foundation
import SwiftUI
import BlessingKit

enum MatterSection {
  case past
  case upcoming
}

@MainActor
final class Store: ObservableObject {
  @Published var matters: [Matter] = []
  @Published var journal: Journal? = Journal.personal

  private let service = MatterService()

  init() {
    Task(priority: .medium) {
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

  var pastMatters: [Matter] {
    matters.filter { $0.occurrenceDate < Date() }
  }

  var upcomingMatters: [Matter] {
    matters.filter { $0.occurrenceDate >= Date() }
  }

  var creating: Binding<Matter> {
    Binding<Matter> {
      return self.matters[0]
    } set: { newValue in
      self.matters[0] = newValue
    }
  }

  @discardableResult
  func newMatter() -> Bool {
    let matter = Matter(id: "")
    matters.insert(matter, at: 0)
    return true
  }

  func cancel(matter: Matter) {
    if matter.id.isEmpty {
      matters.removeAll(where: { $0.id == matter.id })
    }
  }

  func save(matter: Matter) {
    guard let index = matters.firstIndex(where: { $0.id == matter.id }) else {
      return
    }

    // save to disk
    if matter.id.isEmpty {
      matters[index].id = UUID().uuidString
    }
  }

  func delete(at offsets: IndexSet, in section: MatterSection) {
    let selections = section == .past ? pastMatters : upcomingMatters
    let deletes = offsets.map { selections[$0] }
    matters.removeAll(where: { deletes.contains($0) })
  }
}

extension Store {
  static let preview = Store()
}

extension Matter {
  static let new = Matter(id: UUID().uuidString, title: "Getting started")
}
