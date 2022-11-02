//
//  LoginViewController.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/2/22.
//

import UIKit
import Alamofire

struct Login: Codable {
    let token: String
}

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orange
        
        let router = APIRouter.login(email: "hoi99@gmail.com", password: "12345678")
        
        AF.request(router).responseDecodable(of: Login.self) { response in
            
            switch response.result {
            case .success(let data):
                print(data.token)
                
                UserDefaults.standard.set(data.token, forKey : "token")
                
            case.failure(_):
                print(response.response?.statusCode)
            }
            
        }
    }
    
    
    

        
    

    

}

extension LoginViewController {
    
    
    
    // 첫실행 여부 확인함수
    func checkFirstRun() {
        if UserDefaults.standard.bool(forKey: "isSignUp") == false {
            let vc = SignUpViewController()
//            transition(vc, transitionStyle: .presentFull)
        }
    }
}
