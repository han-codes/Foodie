//
//  MealSuggestionsView.swift
//  Foodie
//
//  Created by Hannie Kim on 12/22/21.
//

import UIKit

class MealSuggestionsView: UIView {
    
    // MARK: - UI Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Meal Name"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    let seeDetailsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("See details", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(seeDetailsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let refreshButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.triangle.2.circlepath.circle"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(refreshButtonPressed), for: .touchUpInside)
        return button
    }()
        
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = .checkmark
        return imageView
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setUpSubviews() {
        addSubview(titleLabel)
        addSubview(seeDetailsButton)
        addSubview(imageView)
        addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            
            seeDetailsButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            seeDetailsButton.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8),
            seeDetailsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            refreshButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            refreshButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            refreshButton.heightAnchor.constraint(equalToConstant: 20),
            refreshButton.widthAnchor.constraint(equalTo: refreshButton.heightAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc func seeDetailsButtonPressed() {
        print("See details button pressed")
    }
    
    @objc func refreshButtonPressed() {
        print("Refresh button pressed")
    }
}
