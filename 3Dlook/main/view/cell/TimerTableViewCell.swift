//
//  TimerTableViewCell.swift
//  3Dlook
//
//  Created by Тимур Кошевой on 25.08.2020.
//  Copyright © 2020 homeAssignment. All rights reserved.
//

import UIKit

class TimerTableViewCell: UITableViewCell {
    private let padding: CGFloat = 32.0
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    private func setupView() {
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding / 4),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding / 4),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding / 4),
        ])
    }
    
    private func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: padding / 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding / 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding / 4),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding / 4),
        ])
    }
    
    public func setupCellWithTimer(_ timer: TimerModel) {
        timeLabel.setTextFromSeconds(timer.seconds)
        descriptionLabel.text = timer.note
    }
}
