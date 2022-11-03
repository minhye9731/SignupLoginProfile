//
//  BaseViewController.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/2/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        setConstraints()
    }
    
    func configure() { }
    
    func setConstraints() { }
    
    func showAlertMessageDetail(title: String, message: String, button: String = "확인") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}

