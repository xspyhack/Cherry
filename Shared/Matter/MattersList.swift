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
  @State var selection: Matter?

  var body: some View {
    List(selection: $selection) {
      Section {
        ForEach(store.pastMatters) { matter in
          NavigationLink(value: matter.id) {
            MatterRow(matter: matter)
          }
        }
      } header: {
        Text("Past")
          .sectionHeader()
          .listRowInsets(.headerInsets)
      }

      Section {
        ForEach(store.upcomingMatters) { matter in
          NavigationLink(value: matter.id) {
            MatterRow(matter: matter)
          }
        }
      } header: {
        Text("Upcoming")
          .sectionHeader()
          .listRowInsets(.headerInsets)
      }
    }
    .listStyle(.sidebar) // collapsible
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
    MattersList(store: Store())
  }
}

struct SectionHeaderModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .fontWeight(.medium).font(.subheadline)
      .foregroundColor(.primary)
      .textCase(.uppercase)
  }
}

extension View {
  func sectionHeader() -> some View {
    modifier(SectionHeaderModifier())
  }
}

fileprivate extension EdgeInsets {
  static let headerInsets = EdgeInsets(top: 6, leading: 0, bottom: 0, trailing: 0)
}
