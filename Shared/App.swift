//
//  CherryApp.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/13.
//

import SwiftUI

@main
struct CherryApp: App {
  var body: some Scene {
    WindowGroup {
      MainView()
    }
    #if os(macOS)
    .defaultSize(width: 1000, height: 650)
    #endif
  }
}
