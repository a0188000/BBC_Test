//
//  UIViewController + Extension.swift
//  EBC_Test
//
//  Created by 沈維庭 on 2021/7/12.
//

import UIKit

extension UIViewController {
    func showAlert(_ title: String,
                   message: String,
                   confirmActionTitle: String? = "確認",
                   confirmAction: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: confirmActionTitle, style: .default, handler: confirmAction)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
