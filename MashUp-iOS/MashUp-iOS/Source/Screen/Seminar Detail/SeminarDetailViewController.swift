//
//  SeminarDetailViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core

final class SeminarDetailViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}

// MARK: - Setup
extension SeminarDetailViewController {
    
    private func setupUI() {
        self.view.backgroundColor = .systemOrange
    }
    
}
