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
        #warning("Splash UI 구현해야합니다. - Booung")
        self.view.backgroundColor = .primary500
    }
    
    func bind(reactor: SplashReactor) {
        self.rx.viewDidLayoutSubviews.take(1).map { .didSetup }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
    }
    
}


