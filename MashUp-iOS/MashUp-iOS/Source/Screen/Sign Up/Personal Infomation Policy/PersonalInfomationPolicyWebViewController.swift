//
//  PersonalInfomationPolicyWebViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/15.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import WebKit
import MashUp_Core
import MashUp_UIKit
import ReactorKit
import RxSwift
import RxCocoa

final class PersonalInfomationPolicyWebViewController: BaseViewController, View {
    
    typealias Reactor = PersonalInfomationPolicyReactor
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.reactor?.action.onNext(.didSetup)
    }
    
    func bind(reactor: Reactor) {
        self.dispatch(to: reactor)
        self.render(reactor)
        self.consume(reactor)
    }
    
    private func dispatch(to reactor: Reactor) {
        self.navigationBar.rightButton.rx.tap
            .map { .didTapClose }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func render(_ reactor: Reactor) {
        reactor.state.compactMap { $0.personalInfomationPolicyURL }
            .distinctUntilChanged()
            .map { URLRequest(url: $0) }
            .onMain()
            .subscribe(onNext: { [weak self] urlRequest in
                self?.webView.load(urlRequest)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$shouldClose)
            .compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] in self?.close() })
            .disposed(by: self.disposeBag)
    }
    
    private func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private let navigationBar = MUNavigationBar()
    private let webView = WKWebView()
    
}
extension PersonalInfomationPolicyWebViewController {
    
    private func setupUI() {
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupAttribute() {
        self.view.backgroundColor = .white
        self.navigationBar.do {
            $0.title = "개인정보방침"
            $0.rightBarItem = .close
        }
        self.webView.do {
            $0.navigationDelegate = self
        }
    }
    
    private func setupLayout() {
        self.view.addSubview(self.navigationBar)
        self.navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.view.addSubview(self.webView)
        self.webView.snp.makeConstraints {
            $0.top.equalTo(self.navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
}

extension PersonalInfomationPolicyWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            return decisionHandler(.cancel)
        }
        if url.absoluteString.contains("https://static.mash-up.kr") {
            decisionHandler(.allow)
        } else {
            decisionHandler(.cancel)
        }
    }
}
