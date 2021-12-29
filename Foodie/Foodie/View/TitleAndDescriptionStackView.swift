//
//  TitleAndDescriptionStackView.swift
//  Foodie
//
//  Created by Hannie Kim on 12/28/21.
//

import UIKit

class TitleAndDescriptionStackView: UIStackView {
    
    // MARK: - Properties
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var descriptionText: String? {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    
    // MARK: - UI Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.Theme.darkBlue
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor.Theme.darkBlue
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setUpUI() {
        addViewProperties()
        addSubviews()
    }
    
    private func addViewProperties() {
        axis = .vertical
        spacing = 10
        backgroundColor = UIColor.Theme.mediumBlue
        layer.cornerRadius = 10
    }
    
    private func addSubviews() {
        addArrangedSubview(titleLabel)
        addArrangedSubview(descriptionLabel)
        
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
