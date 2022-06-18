//
//  MyPageHeaderView+Rx.swift
//  MashUp-iOS
//
//  Created by NZ10221 on 2022/06/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: MyPageHeaderView {
    
    var delegate: DelegateProxy<MyPageHeaderView, MyPageHeaderViewDelegate> {
        MyPageHeaderViewDelegateProxy.proxy(for: self.base)
    }
    
    var didTapSettingButton: Observable<Void> {
        self.delegate.methodInvoked(#selector(MyPageHeaderViewDelegate.myPageHeaderViewDidTapSettingButton(_:))).map { _ in Void() }
    }
    var didTapQuestionMarkButton: Observable<Void> {
        self.delegate.methodInvoked(#selector(MyPageHeaderViewDelegate.myPageHeaderViewDidTapQuestionMarkButton(_:))).map { _ in Void() }
    }
}

class MyPageHeaderViewDelegateProxy:
    DelegateProxy<MyPageHeaderView, MyPageHeaderViewDelegate>,
    DelegateProxyType,
    MyPageHeaderViewDelegate
{
    static func registerKnownImplementations() {
        self.register(make: { myPageHeaderView -> MyPageHeaderViewDelegateProxy in
            MyPageHeaderViewDelegateProxy(parentObject: myPageHeaderView, delegateProxy: self)
        })
    }
    
    static func currentDelegate(for object: MyPageHeaderView) -> MyPageHeaderViewDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: MyPageHeaderViewDelegate?, to object: MyPageHeaderView) {
        object.delegate = delegate
    }
    
}
