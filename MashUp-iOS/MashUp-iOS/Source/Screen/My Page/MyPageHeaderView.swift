//
//  MyPageHeaderView.swift
//  MashUp-iOS
//
//  Created by NZ10221 on 2022/06/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Core
import UIKit

@objc protocol MyPageHeaderViewDelegate: AnyObject {
    @objc optional func myPageHeaderViewDidTapSettingButton(_ view: MyPageHeaderView)
    @objc optional func myPageHeaderViewDidTapQuestionMarkButton(_ view: MyPageHeaderView)
}

final class MyPageHeaderView: BaseView {
    
    weak var delegate: MyPageHeaderViewDelegate?
    
    private let userNameLabel = UILabel()
    private let platformTeamLabel = UILabel()
    private let scoreTitleLabel = UILabel()
    private let questionMarkButton = UIButton()
    private let totalAttendanceScoreLabel = UILabel()
    private let mascotImageView = UIImageView()
    private let settingButton = UIButton()
    
}

