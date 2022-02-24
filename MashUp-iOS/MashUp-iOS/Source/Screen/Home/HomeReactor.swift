//
//  HomeReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import RxSwift
import ReactorKit

final class HomeReactor: Reactor {
    typealias Action = Never
    
    struct State {}
    
    let initialState: State
    
    
    init() {
        self.initialState = State()
    }
}
