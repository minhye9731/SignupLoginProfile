//
//  LoginViewController.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/2/22.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

struct Login: Codable {
    let token: String
}

class LoginViewController: BaseViewController {
    
    let mainView = LoginView()
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }

    override func configure() {
        bind()
    }
    
    func bind () {
        
        let input = LoginViewModel.Input(pwText: mainView.pwTextField.rx.text, tap: mainView.loginButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.validStatus
            .bind(to: mainView.loginButton.rx.isEnabled,
                  mainView.validationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.validText
            .drive(mainView.validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.validStatus
            .withUnretained(self)
            .bind { (vc, value) in
                let color: UIColor = value ? .systemGreen : .darkGray
                vc.mainView.loginButton.backgroundColor = color
            }
            .disposed(by: disposeBag)
        
        output.tap
            .bind { () in
                guard let email = self.mainView.emailTextField.text,
                      let pw = self.mainView.pwTextField.text else { return }
                print("\(email) / \(pw)")
                
                self.login(email: email, pw: pw)
            }
        
    }
    
    func login(email: String, pw: String) {
        let router = APIRouter.login(email: email, password: pw)
        
        // 예외처리 추가 필요
        AF.request(router).responseDecodable(of: Login.self) { response in
            
            switch response.result {
            case .success(let data):
                print(data.token)
                
                UserDefaults.standard.set(data.token, forKey : "token")
                
                // 프로필 화면으로 전환
                let vc = ProfileViewController()
                self.transition(vc, transitionStyle: .presentFullNavigation)
                
            case.failure(_):
                print(response.response?.statusCode)
            }
            
        }
        
    }
    

}

extension LoginViewController {
    
    // 첫실행 여부 확인함수
    func checkLogin() {
        if UserDefaults.standard.object(forKey: "token") == nil {
            // 로그인이 안된 상태
            let vc = SignUpViewController()
            self.transition(vc, transitionStyle: .presentFullNavigation)
        } else {
            // 로그인 된 상태
            let vc = ProfileViewController()
            self.transition(vc, transitionStyle: .presentFullNavigation)
        }
    }
}
