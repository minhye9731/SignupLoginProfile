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
import Toast

final class LoginViewController: BaseViewController {
    
    // MARK: - property
    let mainView = LoginView()
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - lifecycle
    override func loadView() {
        self.view = mainView
    }

    // MARK: - functions
    override func configure() {
        bind()
    }
    
    func bind () {
        let input = LoginViewModel.Input(
            emailText: mainView.emailTextField.rx.text,
            pwText: mainView.pwTextField.rx.text,
            tap: mainView.loginButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.validText
            .drive(mainView.validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.validStatus
            .withUnretained(self)
            .bind { (vc, value) in
                let color: UIColor = value ? .systemGreen : .darkGray
                vc.mainView.loginButton.backgroundColor = color
                vc.mainView.loginButton.isEnabled = value
                vc.mainView.validationLabel.isHidden = value
            }
            .disposed(by: disposeBag)
        
        output.tap
            .withUnretained(self)
            .bind { _ in
                guard let email = self.mainView.emailTextField.text,
                      let pw = self.mainView.pwTextField.text else { return }
                print("\(email) / \(pw)")
                
                self.viewModel.getLogin(email: email, pw: pw)
            }
            .disposed(by: disposeBag)
        
        viewModel.login
            .withUnretained(self)
            .subscribe { (vc, value) in
                print("로그인에 대한 서버 응답을 확인하자! : \(value)")
                if value.token != nil {
                    UserDefaults.standard.set(value.token, forKey : "token")
                    let vc = ProfileViewController()
                    self.transition(vc, transitionStyle: .presentFullNavigation)
                } else {
                    self.showAlertMessageDetail(title: "<알림>", message: "123")  // 미완성
                }
            } onError: { error in
                print(error.localizedDescription)
                self.mainView.makeToast(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }

}

extension LoginViewController {
    
    func checkLogin() {
        if UserDefaults.standard.object(forKey: "token") == nil {
            let vc = SignUpViewController()
            self.transition(vc, transitionStyle: .presentFullNavigation)
        } else {
            let vc = ProfileViewController()
            self.transition(vc, transitionStyle: .presentFullNavigation)
        }
    }
}
