//
//  Observable+Main.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/28.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import RxSwift

extension Observable {
    public func onMain() -> Observable<Element> {
        return self.observe(on: MainScheduler.instance)
    }
}
