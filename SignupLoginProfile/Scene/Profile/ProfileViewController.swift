//
//  ProfileViewController.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/2/22.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

struct Profile: Codable {
    let user: User
}

struct User: Codable {
    let photo: String
    let email: String
    let username: String
}

class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    let viewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func configure() {
        showProfile()
        bind()
    }
    
    func bind() {
        
        let input = ProfileViewModel.Input(tap: mainView.logoutButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.tap
            .bind { () in
                // 로그인 데이터 삭제
                print("로그아웃!!")
                UserDefaults.standard.removeObject(forKey: "token")
                
                print(UserDefaults.standard.string(forKey: "token"))
                 // 회원가입 화면으로 전환
                let vc = SignUpViewController()
                self.transition(vc, transitionStyle: .presentFullNavigation)
                
            }
        
    }
    
    func showProfile() {
        let router = APIRouter.profile
        
        // 예외처리 추가 필요
        AF.request(router).validate().responseDecodable(of: Profile.self) { response in
            
            let code = response.response?.statusCode
            
            switch response.result {
            case .success(let data):
                print(data)
                print("통신은 성공 : \(code)")
                
                self.mainView.setProfileData(data: data)
                
                
            case.failure(_):
                print("실패다...")
                print(response.response?.statusCode)
            }
        }
        
    }
    
    

}
