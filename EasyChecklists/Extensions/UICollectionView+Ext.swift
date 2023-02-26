//
//  UICollectionView+Ext.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 26/02/2023.
//

import UIKit

extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(cellForItemAt indexPath: IndexPath) -> T? {
        dequeueReusableCell(withReuseIdentifier: "\(T.self)",
                            for: indexPath) as? T
    }
    
    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }
}
