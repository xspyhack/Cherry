//
//  DetailView.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/13.
//

import SwiftUI

struct DetailView: View {
  @Binding var selection: Journal?
  var body: some View {
    MatterList(selection: $selection)
  }
}

struct DetailView_Previews: PreviewProvider {
  struct Preview: View {
    @State private var selection: Journal? = .personal
    var body: some View {
      DetailView(selection: $selection)
    }
  }
  static var previews: some View {
    Preview()
  }
}
