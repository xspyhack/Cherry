//
//  Matter.swift
//  Blessing
//
//  Created by alex.huo on 2022/8/13.
//

import Foundation

/// A model that represents a matter.
struct Matter: Codable {
    /// The matter’s unique identifier.
    let id: String

    /// The title for the matter.
    let title: String

    /// The tag for the matter.
    let tag: Tagble

    /// The original occurrence date of the matter.
    let occurrenceDate: Date

    /// The notes associated with the matter.
    let notes: String?

    /// This will be removed after Swift 5.
    init(id: String,
         title: String,
         tag: Tagble = Tagble.random(),
         occurrenceDate: Date,
         notes: String? = nil) {
        self.id = id
        self.title = title
        self.tag = tag
        self.occurrenceDate = occurrenceDate
        self.notes = notes
    }
}

extension Matter {
    enum Kind: Int {
        case past
        case upcoming
    }
}

extension Matter: Hashable {
    static func == (lhs: Matter, rhs: Matter) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
