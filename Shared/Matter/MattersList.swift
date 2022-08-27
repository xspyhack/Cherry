//
//  MattersList.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/13.
//

import SwiftUI
import BlessingKit

struct MattersList: View {
  @ObservedObject var store: Store
  @ObservedObject var coordinator: Coordinator
  @State var selection: Matter?
  @State var isEditing: Bool = false

  var body: some View {
    List(selection: $selection) {
      Section {
        ForEach(store.pastMatters) { matter in
          Button {
            coordinator.path.append(matter.id)
          } label: {
            MatterRow(matter: matter)
          }

        }
      } header: {
        Text("Past")
          .sectionHeader()
          .listRowInsets(.headerInsets)
      }
      .listRowBackground(Color.clear)
      .listRowSeparator(.hidden)

      Section {
        ForEach(store.upcomingMatters) { matter in
          Button {
            coordinator.path.append(matter.id)
          } label: {
            MatterRow(matter: matter)
          }
        }
      } header: {
        Text("Upcoming")
          .sectionHeader()
          .listRowInsets(.headerInsets)
      }
      .listRowBackground(Color.clear)
      .listRowSeparator(.hidden)
    }
    .listStyle(.sidebar) // collapsible
    .toolbar {
      ToolbarItemGroup(placement: .primaryAction) {
          Button {
            isEditing = true
          } label: {
              Label("Create Matter", systemImage: "plus")
          }
        }
    }
#if os(iOS)
    .background(Color(.systemBackground))
#else
    .background(.quaternary.opacity(0.5))
#endif
    .background(Color.white)
    .navigationTitle(store.journal?.title ?? "Matters")
    .navigationDestination(for: Matter.ID.self) { id in
      MatterDetailView(matter: store.matterBinding(for: id))
    }
    .sheet(isPresented: $isEditing) {
      NavigationView {
        MatterEditor(matter: .constant(Matter.new))
      }
      //.navigationViewStyle(.stack)
    }
  }
}

struct MattersList_Previews: PreviewProvider {
  static var previews: some View {
    MattersList(store: Store.preview, coordinator: Coordinator.preview)
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
