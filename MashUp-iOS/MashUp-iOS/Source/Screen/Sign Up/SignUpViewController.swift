//
//  SignUpViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/29.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa
import UIKit
import SnapKit
import Then

final class SignUpViewController: BaseViewController, ReactorKit.View {
    
    typealias Reactor = SignUpReactor
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func bind(reactor: SignUpReactor) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupAttribute() {
        self.view.backgroundColor = .white
        
        self.navigationBar.do {
            $0.title = "회원가입"
            $0.leftIcon = UIImage(systemName: "chevron.backward")
        }
    }
    
    private func setupLayout() {
        self.view.addSubview(self.navigationBar)
        self.navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private let navigationBar = MUNavigationBar()
    private let scrollView = UIScrollView()
}
