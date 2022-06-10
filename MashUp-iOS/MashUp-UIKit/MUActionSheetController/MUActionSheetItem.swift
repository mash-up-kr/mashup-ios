//
//  MUAlertAction.swift
//  MashUp-UIKit
//
//  Created by Booung on 2022/06/11.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

public class MUActionSheetItem {
    
    public enum Style {
        case `default`
        case selected
    }
    
    let title: String
    let style: Style
    let handler: ((MUActionSheetItem) -> Void)?
    
    public init(title: String, style: Style, handler: ((MUActionSheetItem) -> Void)?) {
        self.title = title
        self.style = style
        self.handler = handler
    }
    
}
