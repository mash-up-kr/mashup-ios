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
        return TermsAgreementViewDelegateProxy.proxy(for: self.base)
    }
    
    var hasAgreed: Binder<Bool> {
        return Binder(self.base, binding: { base, value in
            base.hasAgreed = value
        })
    }
    
    var didTapAcceptArea: ControlEvent<Bool> {
        let source = self.delegate
            .methodInvoked(#selector(TermsAgreementViewDelegate.termsAgreementView(_:didTapAcceptArea:)))
            .compactMap { parameters in parameters[safe: 1] as? Bool }
        
        return ControlEvent(events: source)
    }
    
    var didTapSeeMoreButton: ControlEvent<Bool> {
       let source = self.delegate
            .methodInvoked(#selector(TermsAgreementViewDelegate.termsAgreementView(_:didTapSeeMoreButton:)))
            .compactMap { parameters in parameters[safe: 1] as? Bool }
        
       return ControlEvent(events: source)
    }
    
}

final class TermsAgreementViewDelegateProxy:
    DelegateProxy<TermsAgreementView, TermsAgreementViewDelegate>,
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
    
}

