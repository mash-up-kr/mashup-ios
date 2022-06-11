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
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        self.titleLabel.do {
            $0.text = "필수 약관 동의"
        }
        self.termsContainerView.do {
            $0.axis = .horizontal
        }
    }
    
    private func setupLayout() {
        self.view.addSubview(self.popupContentView)
        self.popupContentView.addArrangedSubview(self.topBarView)
        self.topBarView.addSubview(self.separatorView)
        self.popupContentView.addArrangedSubview(self.termsContainerView)
        self.termsContainerView.do {
            $0.addArrangedSubview(self.termsAgreementView)
            $0.addArrangedSubview(self.seeMoreButton)
        }
        self.popupContentView.addArrangedSubview(self.confirmButton)
    }
    
}

struct TermsAgreementViewModel {
    let hasAgreed: Bool
    let title: String
}

final class TermsAgreementView: BaseView {
    
    private let checkImageView = UIImageView()
}
