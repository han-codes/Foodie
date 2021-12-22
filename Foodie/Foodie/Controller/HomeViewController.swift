//
//  ViewController.swift
//  Foodie
//
//  Created by Hannie Kim on 12/22/21.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - UI Properties
    
    let mealSuggestionView: MealSuggestionsView = {
        let view = MealSuggestionsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    let mealCategoriesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUpNavigationBar()
        setUpSubviews()
    }

    // MARK: - UI Setup
    
    private func setUpNavigationBar() {
        navigationItem.title = "Discover"
    }
    
    private func setUpSubviews() {
        
        view.addSubview(mealSuggestionView)
        view.addSubview(mealCategoriesView)
        
        NSLayoutConstraint.activate([
            mealSuggestionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mealSuggestionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mealSuggestionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            mealSuggestionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5),

            mealCategoriesView.topAnchor.constraint(equalTo: mealSuggestionView.bottomAnchor, constant: 75),
            mealCategoriesView.leadingAnchor.constraint(equalTo: mealSuggestionView.leadingAnchor),
            mealCategoriesView.trailingAnchor.constraint(equalTo: mealSuggestionView.trailingAnchor),
            mealCategoriesView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
