//
//  BaseViewController.swift
//  Foodie
//
//  Created by Han Kim on 12/27/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    let spinnerViewController = SpinnerViewController()
    
    func addSpinner() {
        addChild(spinnerViewController)
        spinnerViewController.view.frame = view.frame
        view.addSubview(spinnerViewController.view)
        spinnerViewController.didMove(toParent: self)
    }
    
    func removeSpinner() {
        spinnerViewController.willMove(toParent: nil)
        spinnerViewController.view.removeFromSuperview()
        spinnerViewController.removeFromParent()
    }
}
