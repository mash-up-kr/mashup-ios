//
//  MUActionAlertViewController.swift
//  MashUp-UIKit
//
//  Created by 남수김 on 2022/06/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core

public final class MUActionAlertViewController: BaseViewController {
  private let alertView: MUAlertView
  
  public init(title: String? = nil, message: String? = nil) {
    alertView = MUAlertView(title: title, message: message)
    super.init(nibName: nil, bundle: nil)
    self.modalPresentationStyle = .overFullScreen
    self.modalTransitionStyle = .crossDissolve
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black.withAlphaComponent(0.5)
    setupLayout()
  }
  
  private func setupLayout() {
    view.addSubview(alertView)
    alertView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.width.equalTo(320)
    }
  }
  
  public func addAction(_ action: MUAlertAction) {
    let action = MUAlertAction(title: action.title, style: action.style) {
      self.dismiss(animated: false, completion: {
        action.handler?()
      })
    }
    alertView.addAction(action)
  }
}
