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
    VStack(spacing: 0) {
      header
        .frame(height: 300)
        .background(.white)

      TextEditor(text: .constant(matter.notes ?? ""))
        .foregroundColor(Color.secondary)
        .padding(10)
        .scrollContentBackground(.hidden)
        .background(Color(.quaternarySystemFill))
    }
    .ignoresSafeArea(.all)
    .navigationBarTitle("", displayMode: .inline)
  }

  private var header: some View {
    ZStack {
      Text(matter.title)
        .font(.largeTitle.bold())
        .frame(maxWidth: .infinity)
      VStack {
        Spacer()
        Text(date)
          .font(.footnote)
          .fontWeight(.medium)
      }
    }
    .foregroundColor(Color(hex: matter.tag.rawValue))
    .padding(EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24))
  }

  private var date: String {
    matter.occurrenceDate.formatted(date: .abbreviated, time: .omitted)
  }
}

struct MatterDetailView_Previews: PreviewProvider {
  static var previews: some View {
    MatterDetailView(matter: .constant(.preview)).previewLayout(.device)
  }
}
