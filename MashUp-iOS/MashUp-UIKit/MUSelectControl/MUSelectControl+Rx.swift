//
//  MUSelectControl+Rx.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/31.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension MUSelectControl {
    
    struct Reactive<Menu: MUMenu> {
    let base: MUSelectControl<Menu>
    
    fileprivate init(_ base: MUSelectControl<Menu>) {
      self.base = base
    }
  }
  
  var reactive: Reactive<Menu> {
    return Reactive(self)
  }
    
}

extension MUSelectControl.Reactive {
    
  var selectedMenu: Binder<Menu?> {
      Binder(self.base, binding: { base, menu in
          base.selectedMenu = menu
      })
  }
    
}
