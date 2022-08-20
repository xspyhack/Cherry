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
      .font(.title2).fontWeight(.medium)
      .badge(
        Text(days)
          .foregroundColor(Color(hex: matter.tag.rawValue))
          .font(.largeTitle).fontWeight(.semibold)
      )
  }

  private var days: String {
    matter.days > 0 ? "+\(matter.days)" : "\(matter.days)"
  }
}

struct MatterRow_Previews: PreviewProvider {
  static var previews: some View {
    List {
      MatterRow(matter: .preview)
    }
  }
}

extension Matter {
  static let preview = Matter(
    id: "id",
    title: "Preview",
    occurrenceDate: Date().addingTimeInterval(11000000),
    notes: "Preview matter"
  )
}

extension Matter {
  var days: Int {
    Date().bless.absoluteDays(with: occurrenceDate)
  }
}
