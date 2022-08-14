//
//  MatterDetailView.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/14.
//

import SwiftUI
import Blessing

struct MatterDetailView: View {
  @Binding var matter: Matter

  var body: some View {
    Text(matter.title)
    Text(matter.notes ?? "")
  }
}

struct MatterDetailView_Previews: PreviewProvider {
  static var previews: some View {
    MatterDetailView(matter: .constant(.preview))
  }
}
