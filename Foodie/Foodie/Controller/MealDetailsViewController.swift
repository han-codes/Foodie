//
//  MealDetailsViewController.swift
//  Foodie
//
//  Created by Hannie Kim on 12/26/21.
//

import UIKit

class MealDetailsViewController: UIViewController {
    
    // MARK: - UI Properties
    
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
        view.backgroundColor = .yellow
        return view
    }()
    
    let ingredientsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.backgroundColor = .blue
        return stackView
    }()
    
    let instructionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.backgroundColor = .red
        return stackView
    }()
    
    let ingredientsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ingredients"
        label.textAlignment = .center
        return label
    }()
    
    let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let instructionsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Instructions"
        label.textAlignment = .center
        return label
    }()
    
    let instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
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

        view.backgroundColor = .white
        setUpUI()
    }
    
    // MARK: - UI Setup
    
    private func setUpUI() {
        instructionsLabel.text = mealDetails.instructions.replacingOccurrences(of: "\n", with: "\n\n")
        ingredientsLabel.text = mealDetails.ingredients.joined(separator: ", ")
        
        ingredientsStackView.addArrangedSubview(ingredientsTitleLabel)
        ingredientsStackView.addArrangedSubview(ingredientsLabel)
        
        instructionsStackView.addArrangedSubview(instructionsTitleLabel)
        instructionsStackView.addArrangedSubview(instructionsLabel)
        
        stackView.addArrangedSubview(ingredientsStackView)
        stackView.addArrangedSubview(instructionsStackView)
        stackView.addArrangedSubview(emptyView)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            ingredientsTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            instructionsTitleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
