//
//  SNSButton.swift
//  MashUp-iOS
//
//  Created by 이문정 on 2022/07/15.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import SnapKit
import Then
import UIKit
import MashUp_Core
import MashUp_UIKit
import RxSwift
import RxCocoa


final class SNSButton: BaseView {
    
    enum SNSType {
        case facebook
        case instagram
        case tistory
        case youtube
        case home
        case recruit
    }
    
    private let snsImageView: UIImageView = UIImageView()
    private let snsLabel: UILabel = UILabel()
    fileprivate let button: UIButton = UIButton()
    
    init(snsType: SNSType) {
        super.init(frame: .zero)
        setupUI()
        makeButtonStyle(from: snsType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeButtonStyle(from type : SNSType) {
        switch type {
        case .facebook:
            snsImageView.backgroundColor = .blue
            snsLabel.text = "Facebook"
        case .instagram:
            snsImageView.backgroundColor = .systemPink
            snsLabel.text = "Instagram"
        case .tistory:
            snsImageView.backgroundColor = .orange
            snsLabel.text = "Tistory"
        case .youtube:
            snsImageView.backgroundColor = .red
            snsLabel.text = "Youtube"
        case .home:
            snsImageView.backgroundColor = .purple
            snsLabel.text = "Mash-Up Home"
        case .recruit:
            snsImageView.backgroundColor = .purple
            snsLabel.text = "Mash-Up Recruit"
        }
    }

    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupAttribute() {
        self.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 12
        }
        snsLabel.do {
            $0.font = .pretendardFont(weight: .medium, size: 14)
            $0.textColor = .gray700
        }
        button.do {
            $0.backgroundColor = .clear
        }
    }
    
    private func setupLayout() {
        self.addSubview(snsImageView)
        self.addSubview(snsLabel)
        self.addSubview(button)
        snsImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.top.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }
        snsLabel.snp.makeConstraints {
            $0.top.equalTo(snsImageView.snp.bottom).offset(6)
            $0.centerX.equalTo(snsImageView.snp.centerX)
        }
        button.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
    }
}
extension Reactive where Base: SNSButton {
    var tap: ControlEvent<Void> {
        self.base.button.rx.tap
    }
}
