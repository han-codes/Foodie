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
        label.textColor = UIColor.Theme.darkBlue
        return label
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor.Theme.mediumBlue
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor.Theme.darkBlue
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let moreInfobutton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("More Info", for: .normal)
        button.setTitleColor(UIColor.Theme.darkBlue, for: .normal)
        button.addTarget(self, action: #selector(moreInfoButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let refreshButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.triangle.2.circlepath.circle"), for: .normal)
        button.setTitleColor(UIColor.Theme.lightBlue, for: .normal)
        button.addTarget(self, action: #selector(refreshButtonPressed), for: .touchUpInside)
        return button
    }()
    
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
    
    var imageURL: URL? {
        didSet {
            if let url = imageURL {
                imageView.loadImage(from: url)
            }
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
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
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(headerLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(moreInfobutton)
        contentView.addSubview(refreshButton)
        contentView.addSubview(imageView)
        addSubview(contentView)
    }
    
    private func addConstraints() {
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
            titleLabel.trailingAnchor.constraint(equalTo: refreshButton.leadingAnchor, constant: -8),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: moreInfobutton.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                        
            moreInfobutton.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            moreInfobutton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            moreInfobutton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            moreInfobutton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
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
