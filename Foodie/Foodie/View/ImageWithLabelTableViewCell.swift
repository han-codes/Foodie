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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .checkmark
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Beef"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
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
            leftImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            leftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            leftImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            leftImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 75),
            leftImageView.widthAnchor.constraint(equalToConstant: 120),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 30),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        ])
        
        leftImageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        leftImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
}
