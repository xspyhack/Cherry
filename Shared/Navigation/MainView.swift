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
  @State private var selection: Journal? = Journal.personal
  @State private var path = NavigationPath()

#if os(iOS)
  @Environment(\.scenePhase) private var scenePhase
#endif

  var body: some View {
    NavigationSplitView {
      Sidebar(selection: $selection)
    } detail: {
      NavigationStack(path: $path) {
        DetailView(store: store, selection: $selection)
      }
    }
    .onChange(of: selection) { _ in
      path.removeLast(path.count)
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
