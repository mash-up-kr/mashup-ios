//
//  ClubActivityStyle.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import MashUp_UIKit
import UIKit

enum ClubActivityStyle: CaseIterable {
    case mashupLeader
    case mashupSubleader
    case mashupStaff
    case projectLeader
    case projectSubleader
    case projectDeploySuccess
    case projectDeployFailure
    case seminarAttendance
    case seminarLate
    case seminarAbsent
    case seminarSpeacker
    case hackathonAssistant
    case mashupTechBlog
    case mashupContents
    
    init(clubActivity: ClubActivity) {
        switch clubActivity {
        case .mashupLeader: self = .mashupLeader
        case .mashupSubleader: self = .mashupSubleader
        case .mashupStaff: self = .mashupStaff
        case .projectLeader: self = .projectLeader
        case .projectSubleader: self = .projectSubleader
        case .projectDeploySuccess: self = .projectDeploySuccess
        case .projectDeployFailure: self = .projectDeployFailure
        case .seminarAttendance: self = .seminarAttendance
        case .seminarLate: self = .seminarLate
        case .seminarAbsent: self = .seminarAbsent
        case .seminarSpeacker: self = .seminarSpeacker
        case .hackathonAssistant: self = .hackathonAssistant
        case .mashupTechBlog: self = .mashupTechBlog
        case .mashupContents: self = .mashupContents
        }
    }
}
extension ClubActivityStyle {
    
    var title: String? {
        switch self {
        case .mashupLeader: return "회장"
        case .mashupSubleader: return "부회장"
        case .mashupStaff: return "스태프"
        case .projectLeader: return "프로젝트 팀장"
        case .projectSubleader: return "프로젝트 부팀장"
        case .projectDeploySuccess: return "프로젝트 배포 성공"
        case .projectDeployFailure: return "프로젝트 배포 실패"
        case .seminarAttendance: return "출석"
        case .seminarLate: return "지각"
        case .seminarAbsent: return "결석"
        case .seminarSpeacker: return "전체 세미나 발표"
        case .hackathonAssistant: return "해커톤 준비 위원회"
        case .mashupTechBlog: return "기술 블로그 작성"
        case .mashupContents: return "Mash-Up 콘텐츠 글 작성"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .mashupLeader: return .img_mashupleader
        case .mashupSubleader: return .img_mashupsubleader
        case .mashupStaff: return .img_staff
        case .projectLeader: return .img_projectleader
        case .projectSubleader: return .img_projectsubleader
        case .projectDeploySuccess: return .img_projectsuccess
        case .projectDeployFailure: return .img_projectfail
        case .seminarAttendance: return .img_attendance
        case .seminarLate: return .img_late
        case .seminarAbsent: return .img_absent
        case .seminarSpeacker: return .img_presentation
        case .hackathonAssistant: return .img_hackathonprepare
        case .mashupTechBlog: return .img_techblogwrite
        case .mashupContents: return .img_mashupcontentswrite
        }
    }
}
