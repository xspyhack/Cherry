//
//  MainView.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/13.
//

import SwiftUI

struct MainView: View {

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
        DetailView(selection: $selection)
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
      MainView()
    }
  }
  static var previews: some View {
    Preview()
  }
}
