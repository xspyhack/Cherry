//
//  Logger.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/14.
//

import Foundation

struct Log {

  static func d(_ message: @autoclosure () -> String) {
    print(message())
  }

  static func e(_ message: @autoclosure () -> String) {
    print(message())
  }
}
