//
//  GHButton.swift
//  GetHealthy
//
//  Created by Archana Kumari on 16/09/25.
//

import UIKit

class GHButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor,
         title: String,
         font: UIFont? = nil,
         titleColor: UIColor? = nil,
         cornerRadius: CGFloat? = nil) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure(cornerRadius: cornerRadius, font: font)
    }
    
    private func configure(cornerRadius: CGFloat?, font: UIFont?) {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = cornerRadius ?? 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = font ?? UIFont.preferredFont(forTextStyle: .headline)
    }
}
