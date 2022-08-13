//
//  MatterList.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/13.
//

import SwiftUI

struct MatterList: View {
  @Binding var selection: Journal?

  var body: some View {
    Text("Empty list")
      .navigationTitle(selection?.title ?? "Matters")
  }
}

struct MatterList_Previews: PreviewProvider {
  static var previews: some View {
    MatterList(selection: .constant(.personal))
  }
}
