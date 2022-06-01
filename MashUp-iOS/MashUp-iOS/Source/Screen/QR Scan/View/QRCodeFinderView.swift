//
//  QRCodeFinderView.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core

class QRCodeFinderView: BaseView {
    
    private struct Direction: OptionSet {
        let rawValue: Int
        
        static let top = Direction(rawValue: 1 << 0)
        static let leading = Direction(rawValue: 1 << 1)
        static let trailing = Direction(rawValue: 1 << 2)
        static let bottom = Direction(rawValue: 1 << 3)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        let cornerView1 = self.cornerView(direction: [.top, .leading])
        let cornerView2 = self.cornerView(direction: [.top, .trailing])
        let cornerView3 = self.cornerView(direction: [.bottom, .leading])
        let cornerView4 = self.cornerView(direction: [.bottom, .trailing])
        self.do {
            $0.addSubview(cornerView1)
            $0.addSubview(cornerView2)
            $0.addSubview(cornerView3)
            $0.addSubview(cornerView4)
        }
        cornerView1.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        cornerView2.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }
        cornerView3.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview()
        }
        cornerView4.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
        }
    }
    
    private func cornerView(direction: Direction) -> UIView {
        let view =  UIView()
        if direction.contains(.top) {
            let lineView = UIView().then { $0.backgroundColor = .white }
            view.addSubview(lineView)
            lineView.snp.makeConstraints {
                $0.width.equalTo(26)
                $0.height.equalTo(4)
                $0.top.leading.trailing.equalToSuperview()
            }
        }
        if direction.contains(.leading) {
            let lineView = UIView().then { $0.backgroundColor = .white }
            view.addSubview(lineView)
            lineView.snp.makeConstraints {
                $0.width.equalTo(4)
                $0.height.equalTo(26)
                $0.top.leading.bottom.equalToSuperview()
            }
        }
        if direction.contains(.trailing) {
            let lineView = UIView().then { $0.backgroundColor = .white }
            view.addSubview(lineView)
            lineView.snp.makeConstraints {
                $0.width.equalTo(4)
                $0.height.equalTo(26)
                $0.top.trailing.bottom.equalToSuperview()
            }
        }
        if direction.contains(.bottom) {
            let lineView = UIView().then { $0.backgroundColor = .white }
            view.addSubview(lineView)
            lineView.snp.makeConstraints {
                $0.width.equalTo(26)
                $0.height.equalTo(4)
                $0.bottom.leading.trailing.equalToSuperview()
            }
        }
        return view
    }
    
}

