//
//  UICollectionView+.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

extension UICollectionView {
  
  public typealias ReusableView = UICollectionReusableView & Reusable
  public typealias ReusableCell = UICollectionViewCell & Reusable
  
  public func registerSupplementaryView<SupplementaryView: ReusableView>(_ supplementaryViewType: SupplementaryView.Type) {
    self.register(supplementaryViewType,
                  forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                  withReuseIdentifier: supplementaryViewType.reuseIdentifier)
  }
  
  public func registerSupplementaryFooterView<SupplementaryView: ReusableView>(_ supplementaryViewType: SupplementaryView.Type) {
    self.register(supplementaryViewType,
                  forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                  withReuseIdentifier: supplementaryViewType.reuseIdentifier)
  }
  
  public func registerCell<Cell: ReusableCell>(_ cellType: Cell.Type) {
    self.register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
  }
  
  public func dequeueSupplementaryView<SupplementaryView: ReusableView>(
    _ supplementaryViewType: SupplementaryView.Type,
    for indexPath: IndexPath
  ) -> SupplementaryView? {
    return self.dequeueReusableSupplementaryView(
      ofKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: supplementaryViewType.reuseIdentifier,
      for: indexPath
    ) as? SupplementaryView
  }
  
  public func dequeueSupplementaryFooterView<SupplementaryView: ReusableView>(
    _ supplementaryViewType: SupplementaryView.Type,
    for indexPath: IndexPath
  ) -> SupplementaryView? {
    return self.dequeueReusableSupplementaryView(
      ofKind: UICollectionView.elementKindSectionFooter,
      withReuseIdentifier: supplementaryViewType.reuseIdentifier,
      for: indexPath
    ) as? SupplementaryView
  }
  
  public func dequeueCell<Cell: ReusableCell>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell? {
    return self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? Cell
  }
  
}

extension UICollectionViewDiffableDataSource {
  public convenience init(
    collectionView: UICollectionView,
    cellProvider: @escaping CellProvider,
    supplementaryViewProvider: @escaping SupplementaryViewProvider
  ) {
    self.init(collectionView: collectionView, cellProvider: cellProvider)
    self.supplementaryViewProvider = supplementaryViewProvider
  }
}
