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
        self.rx.viewDidLayoutSubviews.take(1).map { _ in .didSetup }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$step).compactMap { $0 }
        .subscribe(onNext: { [weak self] step in
            switch step {
            case .splash:
                self?.presentSplashViewController()
                
            case .signIn:
                self?.switchToSignInViewController()
                
            case .home(let userSession):
                self?.switchToHomeTabBarController(with: userSession)
            }
        }).disposed(by: self.disposeBag)
    }
    
    
    #warning("DIContainer로 로직 이동해야합니다.")
    let userSessionRepository = FakeUserSessionRepository()
    
    private func presentSplashViewController() {
        guard let authenticationResponder = self.reactor else { return }
        userSessionRepository.stubedUserSession = UserSession(accessToken: "fake.access.token")
        
        let splashViewController = SplashViewController()
        splashViewController.reactor = SplashReactor(
            userSessionRepository: userSessionRepository,
            authenticationResponder: authenticationResponder
        )
        splashViewController.modalPresentationStyle = .fullScreen
        self.present(splashViewController, animated: false, completion: nil)
    }
    
    private func switchToSignInViewController() {
        let signInViewController = self.createSignInViewController()
        signInViewController.modalPresentationStyle = .fullScreen
        if let presentedViewController = self.presentedViewController {
            presentedViewController.dismiss(animated: false, completion: {
                self.present(signInViewController, animated: false, completion: nil)
            })
        } else {
            self.present(signInViewController, animated: false, completion: nil)
        }
    }
    
    private func switchToHomeTabBarController(with userSession: UserSession) {
        let homeTabBarController = HomeTabBarController()
        homeTabBarController.modalPresentationStyle = .fullScreen
        if let presentedViewController = self.presentedViewController {
            presentedViewController.dismiss(animated: false, completion: {
                self.present(homeTabBarController, animated: false, completion: nil)
            })
        } else {
            self.present(homeTabBarController, animated: false, completion: nil)
        }
    }
    
    private func createSignInViewController() -> UIViewController {
        let reactor = SignInReactor(userSessionRepository: self.userSessionRepository)
        let viewController = SignInViewController()
        viewController.reactor = reactor
        return viewController
    }
    
}
