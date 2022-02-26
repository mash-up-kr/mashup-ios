//
//  SeminarDetailViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

final class SeminarDetailViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
}

// MARK: - Setup
extension SeminarDetailViewController {
    
    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = false
    }
    
}
