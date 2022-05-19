//
//  Seminar+Stub.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/03/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
@testable import MashUp_iOS

extension Seminar {
  static func stub(
    id: ID = "fake.id.\(Date.now())",
    speaker: String = "fake.speaker.\(Date.now())",
    title: String = "fake.title.\(Date.now())",
    summary: String = "fake.summary.\(Date.now())",
    venue: String = "fake.venue.\(Date.now())",
    date: Date = .now()
  ) -> Seminar {
    return Seminar(
      id: id,
      speaker: speaker,
      title: title,
      summary: summary,
      venue: venue,
      date: date
    )
  }
}
