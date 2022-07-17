//
//  MyPageRuleViewController.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/06/29.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core
import MashUp_UIKit
import RxSwift

public final class ClubActivityScoreRuleViewController: BaseViewController {
    
    private let navigationBar: MUNavigationBar = MUNavigationBar(frame: .zero)
    private let navigationLineView: UIView = UIView()
    private let scrollView: UIScrollView = UIScrollView()
    private let ruleStackView: UIStackView = UIStackView()
    private let disposeBag: DisposeBag = DisposeBag()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupAttribute() {
        view.backgroundColor = .white
        navigationBar.do {
            $0.rightBarItem = .close
            $0.title = "매시업 출석 점수 제도"
        }
        navigationLineView.backgroundColor = .gray200
        scrollView.contentInset = .init(top: 10, left: 0, bottom: 0, right: 0)
        ruleStackView.do {
            $0.axis = .vertical
            $0.distribution = .equalSpacing
            $0.spacing = 44
        }
    }
    
    private func setupLayout() {
        view.addSubview(navigationBar)
        navigationBar.addSubview(navigationLineView)
        navigationLineView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        view.addSubview(scrollView)
        navigationBar.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        scrollView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.bottom.equalToSuperview()
        }
        scrollView.addSubview(ruleStackView)
        let outCountView = makeOutCountView()
        let minusScoreCaseView = makeScoreCaseView(title: "점수 차감 Case",
                                                   image: UIImage(systemName: "heart"),
                                                   caseString: ["결석 -1", "지각 -0.5", "프로젝트 배포 실패 -0.5"])
        let plusScoreCaseView = makeScoreCaseView(title: "점수 획득 Case",
                                                  image: UIImage(systemName: "heart"),
                                                  caseString:  ["전체 세미나 발표 +1",
                                                                "프로젝트팀 팀장/부팀장 +2",
                                                                "해커톤 준비 위원회 +1",
                                                                "프로젝트 배포 성공 +1",
                                                                "기술 블로그 작성 +1",
                                                                "Mash-Up 콘텐츠 글 작성 +0.5",
                                                                "13기 회장/부회장 +999999999999999999999..."])
        ruleStackView.do {
            $0.addArrangedSubview(outCountView)
            $0.addArrangedSubview(minusScoreCaseView)
            $0.addArrangedSubview(plusScoreCaseView)
        }
        
        ruleStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.verticalEdges.equalToSuperview()
            $0.width.equalToSuperview().offset(-40)
        }
    }
    
    private func bind() {
        navigationBar.rightButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension ClubActivityScoreRuleViewController {
    private func makeOutCountView() -> UIView {
        let containerView: UIView = UIView()
        let outCountTitleView: RuleHeaderView = RuleHeaderView()
        let outCountDescriptionLabel: UILabel = UILabel()
        containerView.addSubview(outCountTitleView)
        containerView.addSubview(outCountDescriptionLabel)
        outCountTitleView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        outCountDescriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(outCountTitleView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
        }
        outCountTitleView.do {
            $0.setText("OutCount란?")
            $0.setImage(UIImage(systemName: "heart"))
        }
        outCountDescriptionLabel.do {
            let text = "원활하고 재밌는 Mash-Up 활동을 위해 만들어진 출석제도입니다. 출석체크는 Mash-Up 전체모임(3점)과 플랫폼 모임(3점)으로 시작 및 실행됩니다.\n\n출석 Outcount 기본 3점으로 시작해서 하나의 모임에서라도 0점으로 기수 끝날 시 해당 기수 수료와 다음 기수 참여가 불가해집니다."
            $0.numberOfLines = 0
            $0.font = .pretendardFont(weight: .regular, size: 14)
            $0.textColor = .gray800
            let attributeString = NSMutableAttributedString(string: text)
            attributeString.addAttributes([.font: UIFont.pretendardFont(weight: .bold, size: 14),
                                           .foregroundColor: UIColor.blue500],
                                          range: NSString(string: text).range(of: "전체모임(3점)과 플랫폼 모임(3점)"))
            attributeString.addAttributes([.font: UIFont.pretendardFont(weight: .bold, size: 14),
                                           .foregroundColor: UIColor.red500],
                                          range: NSString(string: text).range(of: "하나의 모임에서라도 0점으로 기수 끝날 시 해당 기수 수료와 다음 기수 참여가 불가"))
            $0.attributedText = attributeString
        }
        return containerView
    }
    
    private func makeScoreCaseView(title: String, image: UIImage?, caseString: [String]) -> UIView {
        let containerView: UIView = UIView()
        let dotLabelStackView: UIStackView = UIStackView()
        let scoreCaseTitleView: RuleHeaderView = RuleHeaderView()
        containerView.addSubview(scoreCaseTitleView)
        containerView.addSubview(dotLabelStackView)
    
        scoreCaseTitleView.do {
            $0.setText(title)
            $0.setImage(image)
        }
        dotLabelStackView.do {
            $0.spacing = 4
            $0.axis = .vertical
        }
        scoreCaseTitleView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        dotLabelStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(scoreCaseTitleView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
        }
        caseString.forEach {
            let dotLabel = DotLabel()
            dotLabel.text = $0
            dotLabelStackView.addArrangedSubview(dotLabel)
        }
        return containerView
    }
}
