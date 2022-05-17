//
//  InteractiveTextFieldTheme.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/17.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

protocol InteractiveTextFieldTheme {
    var borderColor: UIColor { get }
    var assistiveTextColor: UIColor { get }
    var placeholderColor: UIColor { get }
}

struct ErrorTextFieldTheme: InteractiveTextFieldTheme {
    let borderColor: UIColor = .red
    let assistiveTextColor: UIColor = .red
    let placeholderColor: UIColor = .red
}

struct FocusTextFieldTheme: InteractiveTextFieldTheme {
    let borderColor: UIColor = .purple
    let assistiveTextColor: UIColor = .gray
    let placeholderColor: UIColor = .black
}

struct DefaultTextFieldTheme: InteractiveTextFieldTheme {
    let borderColor: UIColor = .gray
    let assistiveTextColor: UIColor = .gray
    let placeholderColor: UIColor = .black
}
