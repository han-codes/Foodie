//
//  MealDetailsViewController.swift
//  Foodie
//
//  Created by Hannie Kim on 12/26/21.
//

import UIKit

class MealDetailsViewController: UIViewController {
    
    // MARK: - UI Properties
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()
    
    let emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let ingredientsStackView: TitleAndDescriptionStackView = {
        let stackView = TitleAndDescriptionStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.title = "Ingredients"
        return stackView
    }()
    
    let instructionsStackView: TitleAndDescriptionStackView = {
        let stackView = TitleAndDescriptionStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.title = "Instructions"
        return stackView
    }()
    
    // MARK: - Properties
    
    let mealDetails: MealDetails
    
    // MARK: - Initializer
    
    init(mealDetails: MealDetails) {
        self.mealDetails = mealDetails
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.Theme.lightBlue
        navigationItem.title = mealDetails.name
        setUpUI()
    }
    
    // MARK: - UI Setup
    
    private func setUpUI() {
        instructionsStackView.descriptionText = mealDetails.instructions.replacingOccurrences(of: "\n", with: "\n\n")
        ingredientsStackView.descriptionText = mealDetails.ingredients.joined(separator: ", ")
        
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        stackView.addArrangedSubview(ingredientsStackView)
        stackView.addArrangedSubview(instructionsStackView)
        stackView.addArrangedSubview(emptyView)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
