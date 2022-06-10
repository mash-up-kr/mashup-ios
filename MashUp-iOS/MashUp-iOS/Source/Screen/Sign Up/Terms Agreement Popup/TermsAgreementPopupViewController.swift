//
//  TermsConditionAgreementPopupViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/06/11.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Core
import MashUp_UIKit
import UIKit

final class TermsAgreementPopupViewController: BaseViewController {
    
    private let popupContentView = UIStackView()
    private let topBarView = UIView()
    private let titleLabel = UILabel()
    private let closeButton = UIButton()
    private let separatorView = UIView()
    private let termsContainerView = UIStackView()
    private let termsAgreementView = TermsAgreementView()
    private let seeMoreButton = UIButton()
    private let confirmButton = MUButton()
}
extension TermsAgreementPopupViewController {
    
    private func setupAttribute() {
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        self.popupContentView.do {
            $0.axis = .vertical
        }
        self.termsContainerView.do {
            $0.axis = .horizontal
        }
    }
    
    private func setupLayout() {
        self.view.addSubview(self.popupContentView)
        
        self.popupContentView.addArrangedSubview(self.topBarView)
        self.popupContentView.addArrangedSubview(self.termsContainerView)
        self.popupContentView.addArrangedSubview(self.confirmButton)
    }
    
}

struct TermsAgreementViewModel {
    let hasAgreed: Bool
    let title: String
}

final class TermsAgreementView: BaseView {
    
}
