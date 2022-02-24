//
//  BaseViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        Logger.log("\(type(of:self)) init", .custom("🐥"), "", "", "")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Logger.log("\(type(of:self)) init", .custom("🐥"), "", "", "")
    }
    
    deinit {
        Logger.log("\(type(of:self)) deinit", .custom("💀"), "", "", "")
    }
    
}
