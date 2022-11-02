//
//  SignUpViewController.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/2/22.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

class SignUpViewController: BaseViewController {
    
    let mainView = SignUpView()
    let viewModel = SignUpViewModel()
    let disposeBag = DisposeBag()

    override func loadView() {
        self.view = mainView
    }
    
    override func configure() {
        bind()
        
        // #rx에서 view 클릭시 키보드 내리기 적용해보자
    }
    
    func bind() {
        
        let input = SignUpViewModel.Input(pwText: mainView.pwTextField.rx.text, tap: mainView.signUpButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.validStatus
            .bind(to: mainView.signUpButton.rx.isEnabled,
                  mainView.validationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.validText
            .drive(mainView.validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.validStatus
            .withUnretained(self)
            .bind { (vc, value) in
                let color: UIColor = value ? .systemGreen : .darkGray
                vc.mainView.signUpButton.backgroundColor = color
            }
            .disposed(by: disposeBag)
        
        output.tap
            .bind { () in
                print("회원가입 버튼 눌림!")
                guard let name = self.mainView.nameTextField.text,
                      let email = self.mainView.emailTextField.text,
                      let pw = self.mainView.pwTextField.text else { return }
                print("\(name) / \(email) / \(pw)")
                
                self.signUp(name: name, email: email, pw: pw)
            }
        
    }


    func signUp(name: String, email: String, pw: String) {
        let router = APIRouter.signup(userName: name, email: email, password: pw)
        
        // 예외처리 추가 필요
        AF.request(router).responseString { response in
            
            let statuscode = response.response?.statusCode
            let value = response.value
            
            print(statuscode)
            print(value)

            // 성공일 경우에만 화면전환하자
            // 네트워크 오류처리 하자
            self.transition(LoginViewController(), transitionStyle: .presentFullNavigation)
        }
        

    }
    
 
    

}

