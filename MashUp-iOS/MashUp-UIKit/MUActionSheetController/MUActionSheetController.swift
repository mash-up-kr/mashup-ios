//
//  MUActionSheetController.swift
//  MashUp-UIKit
//
//  Created by Booung on 2022/06/11.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import SnapKit
import MashUp_Core

public class MUActionSheetController: BaseViewController {
    
    public var actionSheetItems: [MUActionSheetItem] = []
    
    public init(title: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.dismiss(animated: false)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAttribute()
        self.setupLayout()
    }
    
    public func addAction(_ action: MUActionSheetItem) {
        self.actionSheetItems.append(action)
    }
    
    public func present(on viewController: UIViewController) {
        viewController.present(self, animated: false, completion: { self.slideUp() })
    }
    
    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.slideDown(completion: { _ in
            super.dismiss(animated: flag, completion: completion)
        })
    }
    
    private func slideUp(completion: @escaping (Bool) -> Void = { _ in }) {
        self.headerHeightConstraint?.update(offset: 56)
        UIView.animate(
            withDuration: 0.05,
            animations: { self.view.layoutIfNeeded() },
            completion: { _ in
                self.tableViewHeightConstraint?.update(offset: self.tableHeight)
                UIView.animate(
                    withDuration: 0.25,
                    animations: { self.view.layoutIfNeeded() },
                    completion: completion
                )
            }
        )
    }
    
    private func slideDown(completion: @escaping (Bool) -> Void = { _ in }) {
        self.tableViewHeightConstraint?.update(offset: 0)
        UIView.animate(
            withDuration: 0.25,
            animations: { self.view.layoutIfNeeded() },
            completion: { _ in
                self.headerHeightConstraint?.update(offset: 0)
                UIView.animate(
                    withDuration: 0.05,
                    animations: { self.view.layoutIfNeeded() },
                    completion: completion
                )
            }
        )
    }
    
    private var tableHeight: CGFloat {
        return min(self.maxTableHeight, self.contentHeight)
    }
    
    private var contentHeight: CGFloat {
        CGFloat(self.actionSheetItems.count * 52) + safeAreaBottomPadding
    }
    
    private var maxTableHeight: CGFloat {
        return (safeAreaHeight ?? screenHeight) - 80
    }
    
    private let headerView = UIView()
    private let separatorView = UIView()
    private let titleLabel = UILabel()
    private let tableView = UITableView()
    private var headerHeightConstraint: Constraint?
    private var tableViewHeightConstraint: Constraint?
    
}

extension MUActionSheetController {
    
    private func setupAttribute() {
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        self.headerView.do {
            $0.backgroundColor = .white
        }
        self.separatorView.do {
            $0.backgroundColor = .gray200
        }
        self.titleLabel.do {
            $0.font = .pretendardFont(weight: .semiBold, size: 16)
            $0.textColor = .gray900
            $0.text = self.title
        }
        self.headerView.do {
            $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            $0.layer.cornerRadius = 12
            $0.clipsToBounds = true
        }
        self.tableView.do {
            $0.registerCell(MUActionSheetTableViewCell.self)
            $0.backgroundColor = .white
            $0.dataSource = self
            $0.delegate = self
            $0.rowHeight = 52
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
            $0.isScrollEnabled = self.contentHeight > self.tableHeight
        }
    }
    
    private func setupLayout() {
        self.view.addSubview(self.headerView)
        self.headerView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        self.headerView.addSubview(self.separatorView)
        self.separatorView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
        self.view.addSubview(self.tableView)
        self.headerView.snp.makeConstraints {
            self.headerHeightConstraint = $0.height.equalTo(0).constraint
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.tableView.snp.top)
        }
        self.tableView.snp.makeConstraints {
            self.tableViewHeightConstraint = $0.height.equalTo(0).constraint
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
extension MUActionSheetController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.actionSheetItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(MUActionSheetTableViewCell.self, for: indexPath),
              let item = self.actionSheetItems[safe: indexPath.row]
        else { return MUActionSheetTableViewCell() }
        cell.configure(with: item)
        return cell
    }
    
}
extension MUActionSheetController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedItem = self.actionSheetItems[safe: indexPath.row] else { return }
        tableView.deselectRow(at: indexPath, animated: false)
        selectedItem.handler?(selectedItem)
        self.dismiss(animated: false)
    }
    
}
