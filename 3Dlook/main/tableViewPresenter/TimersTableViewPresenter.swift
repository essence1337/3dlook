//
//  TimersTableViewPresenter.swift
//  3Dlook
//
//  Created by Тимур Кошевой on 25.08.2020.
//  Copyright © 2020 homeAssignment. All rights reserved.
//

import UIKit

typealias TableViewDelegateAndDataSource = UITableViewDelegate & UITableViewDataSource

class TimersTableViewPresenter: NSObject {
    private var timers: [TimerModel]?
    
    public func setDataSource(_ dataSource: [TimerModel]?) {
        guard let timers = dataSource else { return }
        self.timers = timers
    }
}

extension TimersTableViewPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension TimersTableViewPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let timers = timers else { return 0 }
        return timers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timerCell", for: indexPath) as! TimerTableViewCell
        guard let timers = timers else { return cell }
        cell.setupCellWithTimer(timers[indexPath.row])
        return cell
    }
}
