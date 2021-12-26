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
        return view
    }()
    
    lazy var mealCategoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImageWithLabelTableViewCell.self, forCellReuseIdentifier: ImageWithLabelTableViewCell.cellID)
        return tableView
    }()
    
    // MARK: - Properties
    
    var categories: [MealCategory]?
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUpNavigationBar()
        setUpSubviews()
        
        WebService.fetchRandomMealDetails { [weak self] randomMealDetails, error in
            guard let mealDetails = randomMealDetails, error == nil else {
                print("Fetch random meal details failed with error: \(String(describing: error?.localizedDescription))")
                // TODO: Present error alert
                return
            }
            
            DispatchQueue.main.async {
                if let data = try? Data(contentsOf: mealDetails.thumbnailURL) {
                    self?.mealSuggestionView.imageView.image = UIImage(data: data)
                }
                self?.mealSuggestionView.titleLabel.text = mealDetails.name
            }
        }
        
        WebService.fetchMealCategories { [weak self] categories, error in
            guard let categories = categories, error == nil else {
                print("Fetch meal categories failed with error: \(String(describing: error?.localizedDescription))")
                // TODO: Present error alert
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.categories = categories
                self?.mealCategoryTableView.reloadData()
            }
        }
    }

    // MARK: - UI Setup
    
    private func setUpNavigationBar() {
        navigationItem.title = "Discover"
    }
    
    private func setUpSubviews() {
        
        view.addSubview(mealSuggestionView)
        view.addSubview(mealCategoryTableView)
        
        NSLayoutConstraint.activate([
            mealSuggestionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mealSuggestionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mealSuggestionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            mealSuggestionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5),

            mealCategoryTableView.topAnchor.constraint(equalTo: mealSuggestionView.bottomAnchor, constant: 75),
            mealCategoryTableView.leadingAnchor.constraint(equalTo: mealSuggestionView.leadingAnchor),
            mealCategoryTableView.trailingAnchor.constraint(equalTo: mealSuggestionView.trailingAnchor),
            mealCategoryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let category = categories?[indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: ImageWithLabelTableViewCell.cellID, for: indexPath) as? ImageWithLabelTableViewCell else {
            return UITableViewCell()
        }
        
        
        if let data = try? Data(contentsOf: category.thumbnailURL) {
            cell.leftImageView.image = UIImage(data: data)
        }
        
        cell.titleLabel.text = category.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Make network request for meals for the selected category
        
        if let selectedCategory = categories?[indexPath.row] {
            navigationController?.pushViewController(MealsViewController(category: selectedCategory), animated: true)
        }
    }
}
