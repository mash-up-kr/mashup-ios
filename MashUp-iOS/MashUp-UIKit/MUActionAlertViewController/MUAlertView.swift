//
//  MUAlertView.swift
//  MashUp-UIKit
//
//  Created by 남수김 on 2022/06/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core


public final class MUAlertView: BaseView {
  private let labelContainerStackView: UIStackView = UIStackView()
  private let titleLabel: UILabel = UILabel()
  private let descriptionLabel: UILabel = UILabel()
  private let buttonContainerStackView: UIStackView = UIStackView()
  private var actions: [MUAlertAction] = []
  
  public init(title: String?, message: String?) {
    super.init(frame: .zero)
    setupUI()
    titleLabel.text = title
    titleLabel.isHidden = title == nil
    descriptionLabel.text = message
    descriptionLabel.isHidden = message == nil
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    setupLayout()
    setupAttribute()
  }
  
  private func setupAttribute() {
    backgroundColor = .white
    layer.cornerRadius = 20
    labelContainerStackView.axis = .vertical
    labelContainerStackView.spacing = 8
    buttonContainerStackView.spacing = 8
    buttonContainerStackView.distribution = .fillEqually
    titleLabel.font = .pretendardFont(weight: .bold, size: 20)
    titleLabel.textAlignment = .center
    descriptionLabel.font = .pretendardFont(weight: .regular, size: 16)
    descriptionLabel.textAlignment = .center
  }
  
  private func setupLayout() {
    addSubview(labelContainerStackView)
    addSubview(buttonContainerStackView)
    labelContainerStackView.addArrangedSubview(titleLabel)
    labelContainerStackView.addArrangedSubview(descriptionLabel)
    
    labelContainerStackView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalToSuperview().offset(24)
      $0.bottom.equalTo(buttonContainerStackView.snp.top).offset(-32)
    }
    
    buttonContainerStackView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().inset(20)
      $0.height.equalTo(52)
      $0.bottom.equalToSuperview().offset(-24)
    }
  }
  
  @objc private func didTapButton(_ sender: MUButton) {
    guard let index = self.buttonContainerStackView.subviews.firstIndex(of: sender) else { return }
    guard let action = self.actions[safe: index] else { return }
    action.handler?()
  }
  
  func addAction(_ action: MUAlertAction) {
    let button = MUButton(frame: .zero, style: action.style)
    button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    actions.append(action)
    buttonContainerStackView.addArrangedSubview(button)
  }
}
