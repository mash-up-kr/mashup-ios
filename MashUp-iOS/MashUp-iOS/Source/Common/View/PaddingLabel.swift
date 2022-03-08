//
//  PaddingLabel.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {
    
    var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: self.contentInsets))
    }
    
    override var intrinsicContentSize: CGSize {
        let contentSize = super.intrinsicContentSize
        let width = contentSize.width + self.contentInsets.left + self.contentInsets.right
        let height = contentSize.height + self.contentInsets.top + self.contentInsets.bottom
        return CGSize(width: width, height: height)
    }
    
}
