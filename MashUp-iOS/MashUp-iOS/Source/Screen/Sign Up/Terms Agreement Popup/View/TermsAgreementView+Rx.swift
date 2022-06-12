//
//  TermsAgreementView+Rx.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/06/12.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: TermsAgreementView {
    var delegate: DelegateProxy<TermsAgreementView, TermsAgreementViewDelegate> {
        return TermsAgreementViewDelegateProxy(parentObject: self.base, delegateProxy: TermsAgreementViewDelegateProxy.self)
    }
    
    var didTapContentArea: Observable<Bool> {
        self.delegate.methodInvoked(#selector(TermsAgreementViewDelegate.termsAgreementView(_:didTapContentArea:)))
            .compactMap { parameters in parameters[safe: 1] as? Bool }
    }
    
    var didTapSeeMoreButton: Observable<Bool> {
        self.delegate.methodInvoked(#selector(TermsAgreementViewDelegate.termsAgreementView(_:didTapSeeMoreButton:)))
            .compactMap { parameters in parameters[safe: 1] as? Bool }
    }
}

final class TermsAgreementViewDelegateProxy
: DelegateProxy<TermsAgreementView, TermsAgreementViewDelegate>,
  DelegateProxyType,
  TermsAgreementViewDelegate
{
    
    static func registerKnownImplementations() {
        self.register { termsView -> TermsAgreementViewDelegateProxy in
            TermsAgreementViewDelegateProxy(parentObject: termsView, delegateProxy: self)
        }
    }
    
    static func currentDelegate(for object: TermsAgreementView) -> TermsAgreementViewDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: TermsAgreementViewDelegate?, to object: TermsAgreementView) {
        object.delegate = delegate
    }
    
    func termsAgreementView(_ view: TermsAgreementView, didTapContentArea currentTermsAgreement: Bool) {
    }
    
    func termsAgreementView(_ view: TermsAgreementView, didTapSeeMoreButton currentTermsAgreement: Bool) {
        
    }
    
    
}

