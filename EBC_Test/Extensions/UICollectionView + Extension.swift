//
//  UICollectionView + Extension.swift
//  EBC_Test
//
//  Created by 沈維庭 on 2021/7/9.
//

import UIKit

extension UICollectionView {
    func myRegister(cells: [UICollectionViewCell.Type]) {
        for cell in cells {
            self.register(cell.self, forCellWithReuseIdentifier: cell.reuseIdentifier)
        }
    }
    
    func myDequeueReusableCell<T: UICollectionViewCell>(cell: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
