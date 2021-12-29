//
//  MealsViewController.swift
//  Foodie
//
//  Created by Han Kim on 12/24/21.
//

import UIKit

class MealsViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImageWithLabelTableViewCell.self, forCellReuseIdentifier: ImageWithLabelTableViewCell.cellID)
        tableView.backgroundColor = UIColor.Theme.mediumBlue
        return tableView
    }()
    
    // MARK: - Properties
    
    let meals: [Meal]
    let category: MealCategory
    
    // MARK: - Initializer
    
    init(category: MealCategory, meals: [Meal]) {
        self.category = category
        self.meals = meals
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "\(category.title) Meals"
        setUpUI()
    }
    
    // MARK: - UI Setup
    
    private func setUpUI() {
        view.backgroundColor = UIColor.Theme.lightBlue
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension MealsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageWithLabelTableViewCell.cellID, for: indexPath) as? ImageWithLabelTableViewCell else {
            return UITableViewCell()
        }
        
        let meal = meals[indexPath.row]
        
        cell.imageURL = meal.thumbnailURL
        cell.title = meal.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addSpinner()
        
        let selectedMealId = meals[indexPath.row].id
        
        WebService.fetchMealDetails(usingId: selectedMealId) { [weak self] result in
            defer {
                DispatchQueue.main.async {
                    self?.removeSpinner()
                }
            }
            
            switch result {
            case .success(let mealDetails):
                DispatchQueue.main.async {
                    self?.navigationController?.pushViewController(MealDetailsViewController(mealDetails: mealDetails), animated: true)
                }
            case .failure(let error):
                print("Fetching meal details failed with error: \(String(describing: error.localizedDescription))")
                DispatchQueue.main.async {
                    self?.presentRequestFailedAlert(forType: .fetchMealDetails)
                }
            }
        }
    }
}
