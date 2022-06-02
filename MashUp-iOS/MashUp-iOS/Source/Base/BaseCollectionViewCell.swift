//
//  BaseCollectionViewCell.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

open class BaseCollectionViewCell: UICollectionViewCell, Reusable {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
