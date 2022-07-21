//
//  MUNavigationBar.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/30.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import SnapKit
import Then
import MashUp_Core
import RxSwift

public class MUNavigationBar: UIView {
    
    public let leftButton = UIButton()
    public let titleLabel = UILabel()
    public let rightButton = UIButton()
    
    public enum BarItem {
        case back
        case close
        case custom(UIImage)
        
        var icon: UIImage? {
            switch self {
            case .back: return .ic_chevron_left?.resized(side: 24)
            case .close: return .ic_close?.resized(side: 24)
            case .custom(let image): return image.resized(side: 24)
            }
        }
    }
    
    public var title: String? {
        get { self.titleLabel.text }
        set { self.titleLabel.text = newValue }
    }
    
    public var leftBarItem: BarItem? {
        didSet { self.leftIcon = leftBarItem?.icon }
    }
    
    public var rightBarItem: BarItem? {
        didSet { self.rightIcon = rightBarItem?.icon }
    }
    
    private var leftIcon: UIImage? {
        get { self.leftButton.image(for: .normal) }
        set { self.leftButton.setImage(newValue, for: .normal) }
    }
    
    private var rightIcon: UIImage? {
        get { self.rightButton.image(for: .normal) }
        set { self.rightButton.setImage(newValue, for: .normal) }
    }
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupAttribute()
        self.setupLayout()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupAttribute()
        self.setupLayout()
    }
    
    public override var intrinsicContentSize: CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 56)
    }
    
    public var interactiveContentScrollView: UIScrollView? {
        didSet { self.setupBottomSeperator() }
    }
    
    private func setupAttribute() {
        self.titleLabel.do {
            $0.textColor = .gray900
            $0.font = .pretendardFont(weight: .semiBold, size: 16)
        }
        self.bottomSeperator.do {
            $0.backgroundColor = .gray100
            $0.isHidden = true
        }
    }
    
    private func setupLayout() {
        self.addSubview(self.leftButton)
        self.leftButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(8)
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.center.equalToSuperview()
        }
        self.addSubview(self.rightButton)
        self.rightButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
        }
        self.addSubview(self.bottomSeperator)
        self.bottomSeperator.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    private func setupBottomSeperator() {
        guard let scrollView = self.interactiveContentScrollView else { return }
        
        self.disposeBag = DisposeBag()
        guard let disposeBag = self.disposeBag else { return }
        
        let initialOffsetY = scrollView.contentOffset.y
        
        scrollView.rx.contentOffset.map { $0.y }
            .map { $0 <= initialOffsetY }
            .distinctUntilChanged()
            .onMain()
            .bind(to: self.bottomSeperator.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    private let bottomSeperator = UIView()
    private var disposeBag: DisposeBag?
    
}
