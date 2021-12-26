//
//  MealsViewController.swift
//  Foodie
//
//  Created by Han Kim on 12/24/21.
//

import UIKit

class MealsViewController: UIViewController {
    
    // MARK: - UI Properties
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImageWithLabelTableViewCell.self, forCellReuseIdentifier: ImageWithLabelTableViewCell.cellID)
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
        
        navigationItem.title = category.title
        setUpUI()
    }
    
    // MARK: - UI Setup
    
    private func setUpUI() {
        view.backgroundColor = .white
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
        // TODO: Network request to fetch meal details
        navigationController?.pushViewController(MealDetailsViewController(), animated: true)
    }
}
