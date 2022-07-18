//
//  SplashViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import ReactorKit
import RxSwift
import RxCocoa
import SnapKit
import UIKit
import MashUp_Core
import MashUp_UIKit

final class SplashViewController: BaseViewController, ReactorKit.View {
    typealias Reactor = SplashReactor
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAttribute()
        self.setupLayout()
    }
    
    func bind(reactor: SplashReactor) {
        self.rx.viewDidLayoutSubviews.take(1).map { .didSetup }
            .delay(.seconds(2), scheduler: MainScheduler.instance)
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private let splashLogoImageView = UIImageView()
}
extension SplashViewController {
    
    private func setupAttribute() {
        self.view.backgroundColor = .brand500
        self.splashLogoImageView.image = .img_splash
    }
    
    private func setupLayout() {
        self.view.addSubview(self.splashLogoImageView)
        self.splashLogoImageView.snp.makeConstraints {
            $0.width.height.equalTo(200)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(293.0/380.0)
        }
    }
    
}

