//
//  ViewController.swift
//  Foodie
//
//  Created by Hannie Kim on 12/22/21.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUpNavigationBar()
    }

    // MARK: - UI Setup
    
    private func setUpNavigationBar() {
        navigationItem.title = "Discover"
    }
}
