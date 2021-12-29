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

extension MealsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageWithLabelTableViewCell.cellID, for: indexPath) as? ImageWithLabelTableViewCell else {
            return UITableViewCell()
        }
        
        let meal = meals[indexPath.row]
        
        if let data = try? Data(contentsOf: meal.thumbnailURL) {
            cell.leftImageView.image = UIImage(data: data)
        }
        
        cell.titleLabel.text = meal.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addSpinner()
        
        WebService.fetchMealDetails(usingId: meals[indexPath.row].id) { [weak self] mealDetails, error in
            defer { self?.removeSpinner() }
            
            guard let mealDetails = mealDetails, error == nil else {
                print("Fetching meal details failed with error: \(String(describing: error?.localizedDescription))")
                self?.presentRequestFailedAlert(forType: .fetchMealDetails)
                return
            }
            
            DispatchQueue.main.async {
                self?.navigationController?.pushViewController(MealDetailsViewController(mealDetails: mealDetails), animated: true)
            }
        }
    }
}
