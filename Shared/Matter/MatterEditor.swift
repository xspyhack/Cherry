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
  @ObservedObject var store: Store
  @Binding var matter: Matter

  enum Field: Equatable {
    case title
    case tag
    case when
    case notes
  }

  @FocusState private var focused: Field?

  var body: some View {
    Form {
      TextField("Title", text: $matter.title, prompt: Text("What's the Matter"))
        .focused($focused, equals: .title)
      TagblePicker("Tag", selection: $matter.tag)
        .focused($focused, equals: .tag)
      DatePicker("When", selection: $matter.occurrenceDate, displayedComponents: .date)
        .focused($focused, equals: .when)
      AppTextEditor(text: $matter.notes ?? "", placeholder: "Notes")
        .frame(minHeight: 200)
        .focused($focused, equals: .notes)
    }
    .defaultFocus($focused, .title)
    .toolbar {
      ToolbarItemGroup(placement: .confirmationAction) {
        Button {
          store.save(matter: $matter.wrappedValue)
          dismiss()
        } label: {
          Text("Done")
        }
      }

      ToolbarItemGroup(placement: .cancellationAction) {
        Button {
          store.cancel(matter: $matter.wrappedValue)
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
    MatterEditor(store: .preview, matter: .constant(Matter.new))
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
        .padding(.leading, -4)
    }
  }
}

struct TagblePicker: View {
  private let titleKey: LocalizedStringKey
  @Binding var selection: Tagble

  init(_ titleKey: LocalizedStringKey, selection: Binding<Tagble>) {
    self.titleKey = titleKey
    self._selection = selection
  }

  var body: some View {
    HStack {
      Text(titleKey)
      ScrollViewReader { proxy in
        ScrollView(.horizontal) {
          HStack {
            ForEach(Tagble.allCases, id: \.rawValue) { tag in
              ZStack(alignment: .center) {
                Circle()
                  .fill(Color(hex: tag.rawValue)!)
                  .frame(width: 24, height: 24)
                Circle().strokeBorder(.gray, lineWidth: 2)
                  .frame(width: 30, height: 30)
                  .opacity(selection == tag ? 1.0 : 0.0)
              }
              .id(tag.rawValue)
              .contentShape(Circle())
              .onTapGesture {
                selection = tag
              }
            }
          }
        }
        .scrollIndicators(.hidden)
        .padding(.leading, 10)
        .onAppear {
          proxy.scrollTo(selection.rawValue, anchor: .center)
        }
      }
    }
  }
}
