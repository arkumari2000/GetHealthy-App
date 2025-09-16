//
//  ActivityInfoView.swift
//  GetHealthy
//
//  Created by Archana Kumari on 16/09/25.
//

import UIKit

final class ActivityInfoView: UIView {
    
    private let activityLabel = UILabel()
    private let iconImageView = UIImageView()
    private let dataLabel = UILabel()
    
    init(label: String, icon: UIImage?, data: String) {
        super.init(frame: .zero)
        setupUI()
        configure(label: label, icon: icon, data: data)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        activityLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        activityLabel.textAlignment = .center
        
        iconImageView.contentMode = .scaleAspectFit
        
        dataLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        dataLabel.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [activityLabel, iconImageView, dataLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 48),
            iconImageView.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func configure(label: String, icon: UIImage?, data: String) {
        activityLabel.text = label
        iconImageView.image = icon
        dataLabel.text = data
    }
}
