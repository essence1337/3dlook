//
//  StoreManager.swift
//  3Dlook
//
//  Created by Тимур Кошевой on 27.08.2020.
//  Copyright © 2020 homeAssignment. All rights reserved.
//

import Foundation

protocol StoreManagerProtocol: AnyObject {
    func getTimers() -> TimersModel?
    func saveTimers(_ timers: TimersModel?)
}

class StoreManager: StoreManagerProtocol {
    private let timersKey = "timers"
    
    public func saveTimers(_ timers: TimersModel?) {
        guard let timers = timers else { return }
        let defaults = UserDefaults.standard
        defaults.set(try? PropertyListEncoder().encode(timers), forKey: timersKey)
    }
    
    public func getTimers() -> TimersModel? {
        let defaults = UserDefaults.standard
        if let timers =  defaults.object(forKey: timersKey) as? Data {
            let timers = try? PropertyListDecoder().decode(TimersModel.self, from: timers)
            return timers
        } else {
            return nil
        }
    }
}
