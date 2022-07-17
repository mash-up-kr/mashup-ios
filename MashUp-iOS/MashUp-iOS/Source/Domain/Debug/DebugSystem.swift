//
//  DebugSystem.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/06/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import FLEX

protocol DebugSystem {
    func on()
}

extension FLEXManager: DebugSystem {
    
    func on() {
        #if !REAL
        self.showExplorer()
        #endif
    }
    
}
