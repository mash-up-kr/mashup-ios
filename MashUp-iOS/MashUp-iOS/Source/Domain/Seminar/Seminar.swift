//
//  Seminar.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct Seminar {
    typealias ID = String
    
    let id: ID
    let speaker: String
    let title: String
    let summary: String
    let venue: String
    let date: Date
}

extension Seminar {
    static let dummy: [Seminar] = [
        Seminar(id: "seminar.0",
                speaker: "배선영, 이영민",
                title: "1차 매쉬업 세미나 - 디자인팀 🎨",
                summary: "디자인은 역시 Figma",
                venue: .empty,
                date: Date(year: 2022, month: 4, day: 1)),
        Seminar(id: "seminar.1",
                speaker: "김유정, 양민욱",
                title: "2차 매쉬업 세미나 - Android 🤖",
                summary: "폴더블폰은 접혔다 펴졌다.\n 접혔다 펴졌다.\n 접혔다 펴졌다.\n 접혔다 펴졌다.\n 접혔다 펴졌다.\n 접혔다 펴졌다.\n",
                venue: .empty,
                date: Date(year: 2022, month: 4, day: 14)),
        Seminar(id: "seminar.2",
                speaker: "이동영, 김남수, 이문정",
                title: "3차 매쉬업 세미나 - iOS팀 🍎",
                summary: "스위프트는 빠르다 빠른건 스위프트",
                venue: .empty,
                date: Date(year: 2022, month: 4, day: 27)),
        Seminar(id: "seminar.3",
                speaker: "박민수, 김성백, 류하준, 민경빈",
                title: "4차 매쉬업 세미나 - Web팀 🕸",
                summary: "React Vue Angular 의 대통합 파티를 이끌어줄 그는 바로 ~",
                venue: .empty,
                date: Date(year: 2022, month: 5, day: 1)),
        Seminar(id: "seminar.4",
                speaker: "김선재, 최상희",
                title: "5차 매쉬업 세미나 - Node팀 🦕",
                summary: "node를 거꾸로하면 deno",
                venue: .empty,
                date: Date(year: 2022, month: 5, day: 14)),
        Seminar(id: "seminar.5",
                speaker: "전해성, 김지희, 이정원",
                title: "5차 매쉬업 세미나 - Spring팀 🌱",
                summary: "- AOP 프로그래밍\n- JDBC로 데이터 로딩\n- 의존성 자동 주입",
                venue: .empty,
                date: Date(year: 2022, month: 5, day: 27)),
    ]
}
