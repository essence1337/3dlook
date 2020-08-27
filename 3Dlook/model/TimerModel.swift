//
//  TimerModel.swift
//  3Dlook
//
//  Created by Тимур Кошевой on 25.08.2020.
//  Copyright © 2020 homeAssignment. All rights reserved.
//

import Foundation

struct TimersModel: Codable {
    var array: [TimerModel]
    var isActive: Bool
    var isRunning: Bool
}

struct TimerModel: Codable {
    let seconds: Int
    let note: String?
}
