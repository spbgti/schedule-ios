//
//  SettingTVCell.swift
//  schedule
//
//  Created by vladislav on 12.10.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

final class SettingTVCell: UITableViewCell {
    
    private lazy var cellName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var groupDetailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var name: String = "Name" {
        didSet {
            cellName.text = name
        }
    }
    
    var detail: String = "" {
        didSet {
            groupDetailLabel.text = detail
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            groupDetailLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0),
            groupDetailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0),
            groupDetailLabel.widthAnchor.constraint(equalToConstant: 65.0),
            
            cellName.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0),
            cellName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25.0),
            cellName.widthAnchor.constraint(equalToConstant: 140.0)
        ])
    }
    
    private func configure() {
        self.backgroundColor = .white
        
        addSubview(groupDetailLabel)
        addSubview(cellName)
    }
    
}
