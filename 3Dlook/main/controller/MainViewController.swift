//
//  MainViewController.swift
//  3Dlook
//
//  Created by Тимур Кошевой on 25.08.2020.
//  Copyright © 2020 homeAssignment. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    private let mainView = MainView()
    private let tableViewPresenter = TimersTableViewPresenter()
    private let timerManager: TimerManagerProtocol
    private let storeManager: StoreManagerProtocol
    private var timers: TimersModel?
    
    init(timerManager: TimerManagerProtocol, storeManager: StoreManagerProtocol) {
        self.timerManager = timerManager
        self.storeManager = storeManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNotifications()
    }
    
    private func setupView() {
        view = mainView
        timerManager.setDelegate(delegate: self)
        mainView.addTimerLabelTapRecognizers(target: self,
                                             tapAction: #selector(timerTapAction),
                                             doubleTapAction: #selector(timerDoubleTapAction))
        mainView.setTableViewDelegateAndDataSource(tableViewPresenter)
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appMovedToBackground),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appMovedToForeground),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
    }
    
    private func resetTimer() {
        mainView.resetTimerLabelValue()
        timerManager.resetTimer()
    }
    
    private func appendTimers(note: String? = nil, isActive: Bool = false, isRunning: Bool = false) {
        let timer = TimerModel(seconds: timerManager.getSeconds(), note: note)
        if self.timers == nil {
            self.timers = TimersModel(array: [timer], isActive: isActive, isRunning: isRunning)
        } else {
            self.timers?.array.insert(timer, at: 0)
            self.timers?.isRunning = isRunning
            self.timers?.isActive = isRunning
        }
    }
    
    private func updateTableView() {
        tableViewPresenter.setDataSource(timers?.array)
        mainView.tableViewReloadData()
    }
}


extension MainViewController {
    @objc private func timerTapAction() {
        timerManager.toggleTimer()
    }
    
    @objc private func timerDoubleTapAction() {
        if timerManager.isAlive() {
            timerManager.stopTimer()
            showInputDialog { [weak self](note) in
                guard let self = self else { return }
                self.appendTimers(note: note)
                self.updateTableView()
                self.resetTimer()
            }
        }
    }
    
    @objc func appMovedToBackground() {
        if timerManager.isAlive() {
            appendTimers(isActive: true, isRunning: timerManager.isRunning())
        }
        timerManager.stopTimer()
        storeManager.saveTimers(timers)
    }
    
    @objc func appMovedToForeground() {
        var timers = storeManager.getTimers()
        if timers != nil {
            if timers!.isActive {
                guard let currentTimer = timers?.array.first else { return }
                timerManager.startFrom(seconds: currentTimer.seconds, run: timers!.isRunning)
                timers!.array.removeFirst()
                self.timers = timers
                updateTableView()
            }
        }
    }
}

extension MainViewController: TimerManagerDelegate {
    func timeDidChange(seconds: Int) {
        mainView.setTimerLabelValue(seconds: seconds)
    }
}
