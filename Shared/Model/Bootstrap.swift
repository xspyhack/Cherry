//
//  Bootstrap.swift
//  Cerise
//
//  Created by bl4ckra1sond3tre on 2019/3/27.
//  Copyright Β© 2019 blessingsoftware. All rights reserved.
//

import Foundation
import BlessingKit

struct Bootstrap {
    private let charmander = Charmander()
    private let startedKey = "com.cerise.started"

    func start() {
        guard !UserDefaults.standard.bool(forKey: startedKey) else {
            return
        }
        UserDefaults.standard.set(true, forKey: startedKey)

        welcome()
        guiding()
    }

    private func welcome() {
        let matter = Matter(id: UUID().uuidString,
                            title: NSLocalizedString("π Welcome to Cherry", comment: "Welcome title"),
                            occurrenceDate: Date(),
                            notes: NSLocalizedString("Cherry is a simple countdown app.", comment: "Welcome details"))
        do {
            try charmander.store(matter, forKey: matter.storeKey)
        } catch {
            Log.e("Store wlecome matter failed: \(error)")
        }
    }

    // swiftlint:disable line_length
    private func guiding() {
        let notes = """
                    π Welcome! Itβs easy to get started and master Cherry, so letβs show you around.

                    Cherry has three parts:

                    *π _Matters List_*: All your matters live here, there are /UPCOMING/ and /PAST/ sections.
                    *π _Matter Details_*: The matter's details contains /Title/, /Tag/, /When/ and /Notes/.
                    *π _Editor_*: This is where you can add your matters.

                    *π Add a new matter*: You can `pull down` or `tap +` in home page (_Matters List_) to add a new matter.

                    *π View matter details*: You can `tap` a matter in _Matters List_ to view the matter details, or use `3D Touch` to preview (If 3D Touch is available). And then you can use `3D Touch` to pop back to _Matters List_ page (If 3D Touch is available).

                    *β Delete a matter*: You can use `swipe left` gesture to ~delete~ a matter in the _Matters List_.

                    Enjoy yourself. π»
                    """
        Log.d(notes)
        // use localized key `getting_started_guide` instead notes
        let matter = Matter(id: UUID().uuidString,
                            title: NSLocalizedString("π Getting Started", comment: "Guide title"),
                            occurrenceDate: Date(timeIntervalSinceNow: 233_333),
                            notes: NSLocalizedString("getting_started_guide", comment: "Guide details"))

        do {
            try charmander.store(matter, forKey: matter.storeKey)
        } catch {
            Log.e("Store getting started matter failed: \(error)")
        }
    }
    // swiftlint:enble line_length
}
