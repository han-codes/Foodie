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
    
    let categoryHeaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Meal Categories"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    lazy var mealCategoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 20
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.backgroundColor = .lightGray
        tableView.register(ImageWithLabelTableViewCell.self, forCellReuseIdentifier: ImageWithLabelTableViewCell.cellID)
        return tableView
    }()
    
    // MARK: - Properties
    
    var categories: [MealCategory]?
    
    // MARK: - Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - UI Setup
    
    private func setUpSubviews() {
        
        view.addSubview(mealSuggestionView)
        view.addSubview(categoryHeaderLabel)
        view.addSubview(mealCategoryTableView)
        
        NSLayoutConstraint.activate([
            mealSuggestionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mealSuggestionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mealSuggestionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mealSuggestionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30),
            
            categoryHeaderLabel.topAnchor.constraint(equalTo: mealSuggestionView.bottomAnchor, constant: 50),
            categoryHeaderLabel.leadingAnchor.constraint(equalTo: mealSuggestionView.leadingAnchor, constant: 5),
            categoryHeaderLabel.trailingAnchor.constraint(equalTo: mealSuggestionView.trailingAnchor),
            
            mealCategoryTableView.topAnchor.constraint(equalTo: categoryHeaderLabel.bottomAnchor),
            mealCategoryTableView.leadingAnchor.constraint(equalTo: mealSuggestionView.leadingAnchor),
            mealCategoryTableView.trailingAnchor.constraint(equalTo: mealSuggestionView.trailingAnchor),
            mealCategoryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
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
        if let selectedCategory = categories?[indexPath.row] {
            WebService.fetchMealsByCategory(selectedCategory.title) { [weak self] meals, error in
                guard let meals = meals, error == nil else {
                    print("Fetching meals failed with error: \(String(describing: error?.localizedDescription))")
                    // TODO: Present error alert
                    return
                }
                
                DispatchQueue.main.async {
                    self?.navigationController?.pushViewController(MealsViewController(category: selectedCategory, meals: meals), animated: true)
                }
            }
        }
    }
}
