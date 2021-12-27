//
//  SpinnerViewController.swift
//  Foodie
//
//  Created by Han Kim on 12/27/21.
//

import UIKit

class SpinnerViewController: UIViewController {
    
    let spinner: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
