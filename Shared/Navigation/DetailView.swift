//
//  DetailView.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/13.
//

import SwiftUI

struct DetailView: View {
  @ObservedObject var store: Store
  @ObservedObject var coordinator: Coordinator

  var body: some View {
    MattersList(store: store, coordinator: coordinator)
  }
}

struct DetailView_Previews: PreviewProvider {
  struct Preview: View {
    @State private var selection: Journal? = .personal
    var body: some View {
      DetailView(store: .preview, coordinator: .preview)
    }
  }
  static var previews: some View {
    Preview()
  }
}
