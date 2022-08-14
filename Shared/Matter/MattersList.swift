//
//  MattersList.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/13.
//

import SwiftUI
import Blessing

struct MattersList: View {
  @ObservedObject var store: Store
  @Binding var selection: Journal?

  var body: some View {
    List(store.matters) { matter in
      NavigationLink(value: matter.id) {
        MatterRow(matter: matter)
      }
    }
    #if os(iOS)
    .background(Color(uiColor: .systemGroupedBackground))
    #else
    .background(.quaternary.opacity(0.5))
    #endif
    .background()
    .navigationTitle(selection?.title ?? "Matters")
    .navigationDestination(for: Matter.ID.self) { id in
      MatterDetailView(matter: store.matterBinding(for: id))
    }
  }
}

struct MattersList_Previews: PreviewProvider {
  static var previews: some View {
    MattersList(store: Store(), selection: .constant(.personal))
  }
}
