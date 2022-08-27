//
//  MatterEditor.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/27.
//

import SwiftUI
import BlessingKit

struct MatterEditor: View {
  @Environment(\.dismiss) var dismiss
  @Binding var matter: Matter

  var body: some View {
    Form {
      TextField("Title", text: $matter.title, prompt: Text("What's the Matter"))
      DatePicker("When", selection: $matter.occurrenceDate, displayedComponents: .date)
      AppTextEditor(text: $matter.notes ?? "", placeholder: "Notes")
        .frame(minHeight: 200)
    }
    .toolbar {
      ToolbarItemGroup(placement: .confirmationAction) {
        Button {
        } label: {
          Label("Save Matter", systemImage: "plus")
        }
      }

      ToolbarItemGroup(placement: .cancellationAction) {
        Button {
          dismiss()
        } label: {
          Text("Cancel")
        }
      }
    }
    .navigationTitle("New Matter")
  }
}

struct MatterEditor_Previews: PreviewProvider {
  static var previews: some View {
    MatterEditor(matter: .constant(Matter.new))
  }
}

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
  Binding(
    get: { lhs.wrappedValue ?? rhs },
    set: { lhs.wrappedValue = $0 }
  )
}

struct AppTextEditor: View {
  @Binding var text: String
  let placeholder: LocalizedStringKey

  var body: some View {
    ZStack(alignment: .topLeading) {
      if text.isEmpty {
        Text(placeholder)
          .foregroundColor(Color(.placeholderText))
          .padding(.top, 8)
      }
      TextEditor(text: $text)
        .padding(.leading, -3)
    }
  }
}
