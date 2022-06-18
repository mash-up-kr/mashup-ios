//
//  MyPageSummaryBar+Rx.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/06/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: MyPageSummaryBar {
    var delegate: DelegateProxy<MyPageSummaryBar, MyPageSummaryBarDelegate> {
        return MyPageSummaryBarDelegateProxy.proxy(for: self.base)
    }
    
    var didTapSettingButton: ControlEvent<Void> {
        let source = self.delegate
            .methodInvoked(#selector(MyPageSummaryBarDelegate.myPageHeaderViewDidTapQuestionMarkButton(_:)))
            .map { _ in Void() }
        return ControlEvent(events: source)
    }
}

final class MyPageSummaryBarDelegateProxy:
    DelegateProxy<MyPageSummaryBar, MyPageSummaryBarDelegate>,
    DelegateProxyType,
    MyPageSummaryBarDelegate {
    static func registerKnownImplementations() {
        self.register {
            myPageSummaryBar -> MyPageSummaryBarDelegateProxy in
            MyPageSummaryBarDelegateProxy(parentObject: myPageSummaryBar, delegateProxy: self)
        }
    }
    
    static func currentDelegate(for object: MyPageSummaryBar) -> MyPageSummaryBarDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: MyPageSummaryBarDelegate?, to object: MyPageSummaryBar) {
        object.delegate = delegate
    }
    
    
}
