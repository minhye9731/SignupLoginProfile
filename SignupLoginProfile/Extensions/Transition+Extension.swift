//
//  Transition+Extension.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/2/22.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present
        case presentNavigation
        case push
    }
    
    func transition(_ vc: UIViewController, transitionStyle: TransitionStyle) {
        
        switch transitionStyle {
        case .present:
            self.present(vc, animated: true)
        case .presentNavigation:
            let navi = UINavigationController(rootViewController: vc)
            self.present(navi, animated: true)
        case .push:
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
