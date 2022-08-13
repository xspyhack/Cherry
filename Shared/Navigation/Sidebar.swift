//
//  Sidebar.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/13.
//

import SwiftUI

struct Sidebar: View {

  @Binding var selection: Journal?

  var body: some View {
    List(selection: $selection) {
      NavigationLink(value: Journal.personal) {
        Label("Personal", systemImage: "folder")
      }

      NavigationLink(value: Journal.family) {
        Label("Family", systemImage: "folder.badge.person.crop")
      }
    }
    .navigationTitle("Cherry")
#if os(macOS)
    .navigationSplitViewColumnWidth(min: 200, ideal: 200)
#endif
  }
}

struct Sidebar_Previews: PreviewProvider {
  struct Preview: View {
    @State private var selection: Journal? = Journal.personal
    var body: some View {
      Sidebar(selection: $selection)
    }
  }

  static var previews: some View {
    NavigationSplitView {
      Preview()
    } detail: {
      Text("Detail!")
    }
  }
}
