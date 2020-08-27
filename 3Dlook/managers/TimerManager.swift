//
//  TimerManager.swift
//  3Dlook
//
//  Created by Тимур Кошевой on 27.08.2020.
//  Copyright © 2020 homeAssignment. All rights reserved.
//

import Foundation

protocol TimerManagerProtocol: AnyObject {
    func setDelegate(delegate: TimerManagerDelegate)
    func isRunning() -> Bool
    func isAlive() -> Bool
    func startFrom(seconds: Int, run: Bool)
    func toggleTimer()
    func stopTimer()
    func resetTimer()
    func handleEnterBackground()
    func handleEnterForeground()
    func getSeconds() -> Int
}

protocol TimerManagerDelegate: class {
    func timeDidChange(seconds: Int)
}

class TimerManager: TimerManagerProtocol {
    private var timer: Timer?
    private var seconds = 0 {
        didSet {
            delegate?.timeDidChange(seconds: seconds)
        }
    }
    
    weak var delegate: TimerManagerDelegate?
    
    public func setDelegate(delegate: TimerManagerDelegate) {
        self.delegate = delegate
    }
    
    public func isRunning() -> Bool {
        guard let timer = timer else { return false }
        return timer.isValid
    }
    
    public func isAlive() -> Bool {
        return timer != nil ? true : false
    }
    
    public func startFrom(seconds: Int, run: Bool) {
        self.seconds = seconds
        if run {
            startTimer()
        }
    }
    
    public func toggleTimer() {
        if isRunning() {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    public func resetTimer() {
        timer = nil
        seconds = 0
    }
    
    public func handleEnterBackground() {
    }
    
    public func handleEnterForeground() {
    }
    
//    public func getSeconds() -> Int? {
//        if seconds == 0 {
//            return nil
//        }
//        return seconds
//    }
    public func getSeconds() -> Int {
        return seconds
    }
}

extension TimerManager {
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.timerAction()
        }
    }
    
    private func timerAction() {
        seconds += 1
    }
}
