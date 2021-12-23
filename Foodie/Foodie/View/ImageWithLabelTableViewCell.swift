//
//  ImageWithLabelTableViewCell.swift
//  Foodie
//
//  Created by Hannie Kim on 12/22/21.
//

import UIKit

class ImageWithLabelTableViewCell: UITableViewCell {
    
    // MARK: - UI Properties
    
    let leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .checkmark
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Beef"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Properties
    
    static let cellID = String(describing: ImageWithLabelTableViewCell.self)
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .lightGray
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setUpSubviews() {
        contentView.addSubview(leftImageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            leftImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            leftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            leftImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            leftImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 75),
            leftImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 100),
            leftImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: leftImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 30),
            titleLabel.bottomAnchor.constraint(equalTo: leftImageView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        ])
    }
}
