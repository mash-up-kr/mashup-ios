//
//  UICollectionView+.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    typealias ReusableView = UICollectionReusableView & Reusable
    typealias ReusableCell = UICollectionViewCell & Reusable
    
    func registerSupplementaryView<SupplementaryView: ReusableView>(_ supplementaryViewType: SupplementaryView.Type) {
        self.register(supplementaryViewType,
                      forSupplementaryViewOfKind: supplementaryViewType.reuseIdentifier,
                      withReuseIdentifier: supplementaryViewType.reuseIdentifier)
    }
    func registerCell<Cell: ReusableCell>(_ cellType: Cell.Type) {
        self.register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func dequeueSupplementaryView<SupplementaryView: ReusableView>(
        _ supplementaryViewType: SupplementaryView.Type,
        for indexPath: IndexPath
    ) -> SupplementaryView? {
        return self.dequeueReusableSupplementaryView(
            ofKind: supplementaryViewType.reuseIdentifier,
            withReuseIdentifier: supplementaryViewType.reuseIdentifier,
            for: indexPath
        ) as? SupplementaryView
    }
    
    func dequeueCell<Cell: ReusableCell>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell? {
        return self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? Cell
    }
    
}

extension UICollectionViewDiffableDataSource {
    convenience init(
        collectionView: UICollectionView,
        cellProvider: @escaping CellProvider,
        supplementaryViewProvider: @escaping SupplementaryViewProvider
    ) {
        self.init(collectionView: collectionView, cellProvider: cellProvider)
        self.supplementaryViewProvider = supplementaryViewProvider
    }
}
