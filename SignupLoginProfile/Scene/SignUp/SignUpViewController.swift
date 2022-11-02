//
//  SignUpViewController.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/2/22.
//

import UIKit
import Alamofire

class SignUpViewController: BaseViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        let router = APIRouter.signup(userName: "hoi99", email: "hoi99@gmail.com", password: "12345678")
        
        AF.request(router).responseString { response in
            
            let statuscode = response.response?.statusCode
            let value = response.value

            print(statuscode)
            print(value)
        }

//        let configuration = URLSessionConfiguration.af.default
//        let session = Session(configuration: configuration)
        
//        let api = APIRouter.signup(userName: "testEmily5", email: "testEmily5@testEmily.com", password: "12345678")
        
//        let router = APIRouter(path: APIRouter.signup, )
        
//        session.request(APIRouter.signup(userName: "testEmily3", email: "testEmily3@testEmily.com", password: "12345678"))
//            .validate()
//            .responseString { response in
//
//                let statuscode = response.response?.statusCode
//                let value = response.value
//
//                print(statuscode)
//                print(value)
//            }
//
//        AF.request(api).validate().responseString { response in
//            print(response)
//            print(response.response?.statusCode)
//        }
   
//            "userName": "testEmily3",
//            "email": "testEmily3@testEmily.com",
//            "password": "12345678"

        

    }

    

    

}

