//
//  ProfileViewController.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/2/22.
//

import UIKit
import Alamofire

struct Profile: Codable {
    let user: User
}

struct User: Codable {
    let photo: String
    let email: String
    let username: String
}

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
        
        print(UserDefaults.standard.string(forKey: "token")!)
        
        let router = APIRouter.profile
        
        AF.request(router).validate().responseDecodable(of: Profile.self) { response in
            
            let code = response.response?.statusCode
            
            switch response.result {
            case .success(let data):
                print(data)
                print("통신은 성공 : \(code)")
                
            case.failure(_):
                print("실패다...")
                print(response.response?.statusCode)
            }
        }
        
    }
    
    
    

}
