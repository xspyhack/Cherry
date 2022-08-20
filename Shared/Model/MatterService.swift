//
//  MatterService.swift
//  Cherry
//
//  Created by alex.huo on 2022/8/14.
//

import Foundation
import BlessingKit

final class MatterService {
  let charmander = Charmander()

  /*
  func loadAll() async -> [Matter] {
    await withUnsafeContinuation { continuation in
      DispatchQueue.global(qos: .default).async {
        let matters = try? self.charmander.retrieveAll(type: Matter.self)
        continuation.resume(returning: matters ?? [])
      }
    }
  }
  */

  func loadAll() async -> [Matter] {
    let matters = try? charmander.retrieveAll(type: Matter.self)
    return matters ?? []
  }
}
