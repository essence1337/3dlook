//
//  UILabel+Extension.swift
//  3Dlook
//
//  Created by Тимур Кошевой on 27.08.2020.
//  Copyright © 2020 homeAssignment. All rights reserved.
//

import UIKit

extension UILabel {
    func setTextFromSeconds(_ seconds: Int) {
        let minutes = seconds / 60 % 60
        let seconds = seconds % 60
        self.text = String(format:"%02i:%02i", minutes, seconds)
    }
}
