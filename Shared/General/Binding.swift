//
//  Binding.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/28.
//

import SwiftUI

/// Optional binding
func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
  Binding(
    get: { lhs.wrappedValue ?? rhs },
    set: { lhs.wrappedValue = $0 }
  )
}
