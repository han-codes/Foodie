//
//  MealSuggestionsView.swift
//  Foodie
//
//  Created by Hannie Kim on 12/22/21.
//

import UIKit

protocol MoreInfoButtonPressable: AnyObject {
    func getMoreInfo()
}

protocol RefreshButtonPressable: AnyObject {
    func refresh()
}

class MealSuggestionsView: UIView {
    
    // MARK: - UI Properties
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Meal Suggestion"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = .lightGray
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    let seeDetailsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("More Info", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(moreInfoButtonPressed), for: .touchUpInside)
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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Properties
    
    weak var moreInfoDelegate: MoreInfoButtonPressable?
    weak var refreshDelegate: RefreshButtonPressable?
    
    // MARK: - Initializer
    
    init(moreInfoDelegate: MoreInfoButtonPressable?, refreshDelegate: RefreshButtonPressable?, frame: CGRect = .zero) {
        self.moreInfoDelegate = moreInfoDelegate
        self.refreshDelegate = refreshDelegate
        
        super.init(frame: frame)
                
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setUpSubviews() {
        addSubview(headerLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(seeDetailsButton)
        contentView.addSubview(refreshButton)
        contentView.addSubview(imageView)
        addSubview(contentView)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            headerLabel.bottomAnchor.constraint(equalTo: contentView.topAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: refreshButton.leadingAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: seeDetailsButton.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            
            seeDetailsButton.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            seeDetailsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            seeDetailsButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            seeDetailsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            refreshButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            refreshButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            refreshButton.heightAnchor.constraint(equalToConstant: 20),
            refreshButton.widthAnchor.constraint(equalTo: refreshButton.heightAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc func moreInfoButtonPressed() {
        print("More Info button pressed")
        moreInfoDelegate?.getMoreInfo()
    }
    
    @objc func refreshButtonPressed() {
        print("Refresh button pressed")
        refreshDelegate?.refresh()
    }
}
