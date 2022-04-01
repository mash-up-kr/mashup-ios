//
//  RxBlocking+.swift
//  MashUp-iOSTests
//
//  Created by 남수김 on 2022/03/22.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import RxSwift

extension ObservableType {
   /// Converts an `Observable` that records last `N` events
   ///
   /// - parameter bufferSize: Number of recent recordable events
   /// - returns: `Observable<Element>` version of `self`
   func recorded(_ bufferSize: Int = 10) -> Observable<Element> {
       let replaySubject = ReplaySubject<Element>.create(bufferSize: bufferSize)
       _ = self.subscribe(replaySubject)
       return replaySubject.asObservable()
   }
}
