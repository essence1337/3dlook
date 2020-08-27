//
//  UIViewController+Extension.swift
//  3Dlook
//
//  Created by Тимур Кошевой on 27.08.2020.
//  Copyright © 2020 homeAssignment. All rights reserved.
//

import UIKit

extension UIViewController {
    func showInputDialog(actionHandler: ((String?) -> Void)? = nil) {
        let alert = UIAlertController(title: "Add a note?", message: "", preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = "note"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action: UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: "Nope", style: .cancel, handler: { (action: UIAlertAction) in
            actionHandler?(nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
