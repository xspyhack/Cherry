//
//  MainView.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/13.
//

import SwiftUI

struct MainView: View {
  /// The app's model that the containing scene passes in.
  @ObservedObject var store: Store
  @StateObject private var coordinator = Coordinator()

#if os(iOS)
  @Environment(\.scenePhase) private var scenePhase
#endif

  var body: some View {
    NavigationSplitView {
      Sidebar(selection: $store.journal)
    } detail: {
      NavigationStack(path: $coordinator.path) {
        DetailView(store: store, coordinator: coordinator)
      }
    }
    .onChange(of: store.journal) { _ in
      coordinator.popToRoot()
    }
#if os(macOS)
    .frame(minWidth: 600, minHeight: 450)
#elseif os(iOS)
    .onChange(of: scenePhase) { newValue in
      // TODO
    }
#endif
  }
}

struct MainView_Previews: PreviewProvider {
  struct Preview: View {
    var body: some View {
      MainView(store: .preview)
    }
  }
  static var previews: some View {
    Preview()
  }
}
