//
//  Declarative.swift
//  EBC_Test
//
//  Created by 沈維庭 on 2021/7/9.
//

import UIKit

protocol Declarative { init() }

extension Declarative where Self: NSObject {
    init(_ configureHandler: (Self) -> Void) {
        self.init()
        configureHandler(self)
        print("123")
    }
}

extension Declarative where Self: UICollectionView {
    init(layout: UICollectionViewFlowLayout,
         _ configureHandler: (Self) -> Void) {
        self.init(frame: .zero, collectionViewLayout: layout)
        configureHandler(self)
    }
}

extension NSObject: Declarative { }
