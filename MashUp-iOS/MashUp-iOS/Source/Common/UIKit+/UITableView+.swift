//
//  UITableView+.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

extension UITableView {
    
    typealias ReusableCell = UITableViewCell & Reusable
    
    func registerCell<Cell: ReusableCell>(_ cellType: Cell.Type) {
        self.register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func dequeueCell<Cell: ReusableCell>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell? {
        return self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? Cell
    }
    
}