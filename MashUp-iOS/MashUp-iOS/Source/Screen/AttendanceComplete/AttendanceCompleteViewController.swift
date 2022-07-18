//
//  AttendanceCompleteViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core
import MashUp_UIKit
import ReactorKit

final class AttendanceCompleteViewController: BaseViewController, View {
    
    typealias Reactor = AttendanceCompleteReactor
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAttribute()
        self.setupLayout()
    }
    
    func bind(reactor: Reactor) {
        self.dispatch(to: reactor)
        self.consume(reactor)
    }
    
    private func dispatch(to reactor: Reactor) {
        self.rx.viewDidAppear.take(1)
            .map { _ in .didSetup }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$shouldClose).compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: self.disposeBag)
    }
    
    private let successImageView = UIImageView()
    
}
extension AttendanceCompleteViewController {
    
    private func setupAttribute() {
        self.successImageView.image = .img_success
        self.view.backgroundColor = .black.withAlphaComponent(0.8)
    }
    
    private func setupLayout() {
        self.view.addSubview(self.successImageView)
        self.successImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(232)
            $0.height.equalTo(186)
        }
    }
    
}
