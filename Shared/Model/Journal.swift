//
//  Journal.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/13.
//

import Foundation

/// Journal file
enum Journal: String, Hashable {
  case personal
  case family
}

extension Journal {
  var title: String {
    rawValue.capitalized
  }
}
