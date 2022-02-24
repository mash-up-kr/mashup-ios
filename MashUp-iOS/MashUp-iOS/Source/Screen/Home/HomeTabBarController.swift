//
//  HomeViewController.swift
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

final class HomeTabBarController: BaseTabBarController, ReactorKit.View {
    typealias Reactor = HomeReactor
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: HomeReactor) {
        
    }
    
}
