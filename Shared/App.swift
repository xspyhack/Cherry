//
//  CherryApp.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/13.
//

import SwiftUI

@main
struct CherryApp: App {
  /// The app's state.
  @StateObject private var store = Store()

  var body: some Scene {
    WindowGroup {
      MainView(store: store)
    }
    #if os(macOS)
    .defaultSize(width: 1000, height: 650)
    #endif
  }
}
