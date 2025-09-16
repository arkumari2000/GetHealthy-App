//
//  ActivityInfoView.swift
//  GetHealthy
//
//  Created by Archana Kumari on 16/09/25.
//

import UIKit

enum ActivityType {
    case cycling, walking, running, energy
}

class ActivityInfoView: UIView {
    
    private let containerView = UIView()
    
    private let activityLabel = GHTitleLabel(textAlignment: .left, fontSize: 20)
    private let iconImageView = UIImageView()
    private let dataLabel = GHSecondaryLabel(alignment: .left, fontSize: 16)
    
    private let contrainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let innerVStackView: UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 2
        return vStack
    }()
    
    init() {
        super.init(frame: .zero)
        setupStyle()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupStyle() {
        backgroundColor = UIColor(red: 0.9, green: 0.95, blue: 0.96, alpha: 1)  // pastel light teal
        
        layer.cornerRadius = 20
        layer.masksToBounds = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        
        // Optional: improve shadow performance with shadowPath for smooth curves
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Update shadowPath on layout changes for correct shadow shape
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    private func setupUI() {
        let sidePadding: CGFloat = 15
        let topBottomPadding: CGFloat = 20
        addSubview(contrainerStackView)
        
        setupImageIcon()
        
        NSLayoutConstraint.activate([
            contrainerStackView.topAnchor.constraint(equalTo: topAnchor, constant: topBottomPadding),
            contrainerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sidePadding),
            contrainerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -topBottomPadding),
            contrainerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sidePadding)
        ])
        
        contrainerStackView.addArrangedSubview(iconImageView)
        contrainerStackView.addArrangedSubview(innerVStackView)
        
        innerVStackView.addArrangedSubview(activityLabel)
        innerVStackView.addArrangedSubview(dataLabel)
    }
    
    private func setupImageIcon() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func setData(activityData: Activity) {
        dataLabel.text = activityData.data
        activityLabel.text = activityData.activityLabel
        switch activityData.activityType {
        case .cycling:
            iconImageView.image = UIImage(systemName: SFSymbols.cycle)
        case .walking:
            iconImageView.image = UIImage(systemName: SFSymbols.walk)
        case .running:
            iconImageView.image = UIImage(systemName: SFSymbols.run)
        case .energy:
            iconImageView.image = UIImage(systemName: SFSymbols.energy)
        }
    }
}
