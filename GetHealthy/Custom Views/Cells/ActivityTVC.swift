//
//  ActivityTVC.swift
//  GetHealthy
//
//  Created by Archana Kumari on 16/09/25.
//

import UIKit

class ActivityTVC: UITableViewCell {
    
    static let reuseId = "ActivityTVC"
    private let activityView = ActivityInfoView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(activityData: Activity) {
        activityView.setData(activityData: activityData)
    }
    
    func configure() {
        activityView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(activityView)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            activityView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            activityView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            activityView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            activityView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
    }
}
