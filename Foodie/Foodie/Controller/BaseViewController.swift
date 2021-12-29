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
    
    func presentRequestFailedAlert(forType requestType: RequestType) {
        let alertController = UIAlertController(title: "Error", message: "Sorry, we're unable to \(requestType.rawValue) at this time. Please try again shortly.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alertController, animated: true, completion: nil)        
    }
}
