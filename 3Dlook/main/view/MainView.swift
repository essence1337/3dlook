//
//  MainView.swift
//  3Dlook
//
//  Created by Тимур Кошевой on 25.08.2020.
//  Copyright © 2020 homeAssignment. All rights reserved.
//

import UIKit

class MainView: UIView {
    private let padding: CGFloat = 32.0
    
    private let topContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    private let timerLabel = TimerLabel()
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TimerTableViewCell.self, forCellReuseIdentifier: "timerCell")
        table.estimatedRowHeight = UITableView.automaticDimension
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainView {
    private func setupView() {
        backgroundColor = .white
        setupTopContentView()
        setupTimerLabel()
        setupTableView()
    }
    
    private func setupTopContentView() {
        addSubview(topContentView)
        NSLayoutConstraint.activate([
            topContentView.topAnchor.constraint(equalTo: topAnchor),
            topContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topContentView.bottomAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func setupTimerLabel() {
        topContentView.addSubview(timerLabel)
        NSLayoutConstraint.activate([
            timerLabel.centerYAnchor.constraint(equalTo: topContentView.centerYAnchor),
            timerLabel.centerXAnchor.constraint(equalTo: topContentView.centerXAnchor),
        ])
    }
    
    private func setupTableView() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: centerYAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func secondsToString(_ seconds: Int) -> String {
        let minutes = seconds / 60 % 60
        let seconds = seconds % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}

extension MainView {
    public func setTableViewDelegateAndDataSource(_ delegate: TableViewDelegateAndDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = delegate
    }
    
    public func tableViewInsertRow() {
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        tableView.endUpdates()
    }
    
    public func tableViewReloadData() {
        tableView.reloadData()
    }
    
    public func addTimerLabelTapRecognizers(target: Any?, tapAction: Selector, doubleTapAction: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: tapAction)
        tap.numberOfTapsRequired = 1
        timerLabel.addGestureRecognizer(tap)
        
        let doubleTap = UITapGestureRecognizer(target: target, action: doubleTapAction)
        doubleTap.numberOfTapsRequired = 2
        timerLabel.addGestureRecognizer(doubleTap)
        
        tap.require(toFail: doubleTap)
    }
    
    public func setTimerLabelValue(seconds: Int) {
        timerLabel.setTextFromSeconds(seconds)
    }
    
    public func resetTimerLabelValue() {
        timerLabel.setTextFromSeconds(0)
    }
}
