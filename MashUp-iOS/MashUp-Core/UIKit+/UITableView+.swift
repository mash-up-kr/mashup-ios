//
//  UITableView+.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

extension UITableView {
    
    public typealias ReusableHeaderFooter = UITableViewHeaderFooterView & Reusable
    public typealias ReusableCell = UITableViewCell & Reusable
    
    public func registerHeaderFooter<HeaderFooter: ReusableHeaderFooter>(_ headerFooterType: HeaderFooter.Type) {
        self.register(headerFooterType, forHeaderFooterViewReuseIdentifier: headerFooterType.reuseIdentifier)
    }
    
    public func registerCell<Cell: ReusableCell>(_ cellType: Cell.Type) {
        self.register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    public func dequeueHeaderFooter<HeaderFooter: ReusableHeaderFooter>(_ headerFooterType: HeaderFooter.Type) -> HeaderFooter? {
        self.dequeueReusableHeaderFooterView(withIdentifier: headerFooterType.reuseIdentifier) as? HeaderFooter
    }
    
    public func dequeueCell<Cell: ReusableCell>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell? {
        return self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? Cell
    }
    
}
