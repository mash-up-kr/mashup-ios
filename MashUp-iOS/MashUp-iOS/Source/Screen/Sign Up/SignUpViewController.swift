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
    
}
