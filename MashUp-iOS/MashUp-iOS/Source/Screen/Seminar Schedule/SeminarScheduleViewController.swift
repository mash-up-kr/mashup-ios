//
//  SeminarScheduleViewController.swift
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

final class SeminarScheduleViewController: BaseViewController, ReactorKit.View {
    typealias Reactor = SeminarScheduleReactor
    typealias Section = SeminarScheduleSection
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    func bind(reactor: Reactor) {
        self.dispatch(to: reactor)
        self.render(reactor)
        self.consume(reactor)
    }
    
    private func dispatch(to reactor: Reactor) {
    }
    
    private func render(_ reactor: Reactor) {
        
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$step).compactMap { $0 }
        .subscribe(onNext: { [weak self] step in
            switch step {
            case .seminarDetail(let seminarID):
                self?.pushSeminarDetailViewController(seminarID: seminarID)
            }
        })
        .disposed(by: self.disposeBag)
    }
    
    
}
// MARK: - Setup
extension SeminarScheduleViewController {
    
    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .systemRed
    }
    
}
// MARK: - Navigation
extension SeminarScheduleViewController {
    
    private func pushSeminarDetailViewController(seminarID: String) {
        let seminarDetailViewController = self.createSeminarDetailViewController(seminarID: seminarID)
        self.navigationController?.pushViewController(seminarDetailViewController, animated: true)
    }
    
}
// MARK: - Factory
extension SeminarScheduleViewController {
    
    private func createSeminarDetailViewController(seminarID: String) -> SeminarDetailViewController {
        let seminarDetailViewController = SeminarDetailViewController()
        return seminarDetailViewController
    }
    
}
