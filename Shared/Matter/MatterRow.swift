//
//  MatterRow.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/14.
//

import SwiftUI
import Blessing

struct MatterRow: View {
  var matter: Matter

  var body: some View {
    Text(matter.title)
  }
}

struct MatterRow_Previews: PreviewProvider {
  static var previews: some View {
    MatterRow(matter: .preview)
  }
}

extension Matter {
  static let preview = Matter(
    id: "id",
    title: "Preview",
    occurrenceDate: Date()
  )
}
