//
//  TimerLabel.swift
//  3Dlook
//
//  Created by Тимур Кошевой on 25.08.2020.
//  Copyright © 2020 homeAssignment. All rights reserved.
//

import UIKit

class TimerLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .black
        font = UIFont(name: "Futura-Bold", size: 40)
        text = "00:00"
        isUserInteractionEnabled = true
    }
}
