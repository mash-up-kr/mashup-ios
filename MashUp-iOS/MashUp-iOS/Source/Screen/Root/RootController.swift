//
//  RootViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import ReactorKit
import UIKit

final class RootController: BaseViewController, ReactorKit.View {
    typealias Reactor = RootReactor
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
    }
    
    func bind(reactor: RootReactor) {
        self.dispatch(to: reactor)
        self.consume(reactor)
    }
    
    private func dispatch(to reactor: Reactor) {
        self.rx.viewDidLoad.map { .didSetup }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$step).compactMap { $0 }
        .subscribe(onNext: { step in
            switch step {
            case .splash:
                ()
            case .signIn:
                ()
            case .home(let userSession):
                ()
            }
        }).disposed(by: self.disposeBag)
    }
}
