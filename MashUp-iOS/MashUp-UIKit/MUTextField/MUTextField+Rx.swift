//
//  MUTextField+Rx.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/29.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: MUTextField {
    public var text: ControlProperty<String?> {
        self.base.textField.rx.text
    }
    
    public var status: Binder<MUTextField.Status> {
        Binder(self.base) { base, status in
            base.status = status
        }
    }
}
