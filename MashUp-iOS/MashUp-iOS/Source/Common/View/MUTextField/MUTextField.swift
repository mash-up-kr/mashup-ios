//
//  MUTextField.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/29.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

struct MUTextFieldStyle {
    let borderColor: UIColor
    let textColor: UIColor
    let placeholderColor: UIColor
    let assistiveTextColor: UIColor
    let trailingIconImageSource: ImageSource?
}

enum MUTextFieldStyle {
    case normal
    case forcus
}

class MUTextField: UIView {
    
    
    private func setupAttribute() {}
    
    private func setupLayout() {}
    
    private let textField = UITextField()
    private let placeholder = UILabel()
    private let assistiveLabel = UILabel()
    private let trailingIconImageView = UIImageView()
    
}
