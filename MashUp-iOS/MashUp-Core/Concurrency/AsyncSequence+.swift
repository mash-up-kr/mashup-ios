//
//  AsyncSequence+.swift
//  MashUp-Core
//
//  Created by Booung on 2022/07/20.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

public extension AsyncStream {
    static func single(_ closure: @escaping @Sendable () async -> Element) -> AsyncStream<Element> {
        return AsyncStream(Element.self, bufferingPolicy: .unbounded, { continuation in
            Task.detached {
                let result = await closure()
                continuation.yield(result)
                continuation.finish()
            }
        })
    }
}
