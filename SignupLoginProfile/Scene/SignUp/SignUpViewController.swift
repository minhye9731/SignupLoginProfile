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
import Toast

final class SignUpViewController: BaseViewController {
    
    // MARK: - property
    let mainView = SignUpView()
    let viewModel = SignUpViewModel()
    let disposeBag = DisposeBag()

    // MARK: - lifecycle
    override func loadView() {
        self.view = mainView
    }
    
    // MARK: - functions
    override func configure() {
        bind()
        // #rx에서 view 클릭시 키보드 내리기 적용해보자
    }
    
    func bind() {
        let input = SignUpViewModel.Input(
            nameText: mainView.nameTextField.rx.text,
            emailText: mainView.emailTextField.rx.text,
            pwText: mainView.pwTextField.rx.text,
            tap: mainView.signUpButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.validText
            .drive(mainView.validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.validStatus
            .withUnretained(self)
            .bind { (vc, value) in
                let color: UIColor = value ? .systemGreen : .darkGray
                vc.mainView.signUpButton.backgroundColor = color
                vc.mainView.signUpButton.isEnabled = value
                vc.mainView.validationLabel.isHidden = value
            }
            .disposed(by: disposeBag)
        
        output.tap
            .withUnretained(self)
            .bind { _ in
                guard let name = self.mainView.nameTextField.text,
                      let email = self.mainView.emailTextField.text,
                      let pw = self.mainView.pwTextField.text else { return }
                
                self.viewModel.getSignUp(name: name, email: email, pw: pw)
            }
            .disposed(by: disposeBag)
        
        viewModel.signup
            .withUnretained(self)
            .subscribe { (vc, value) in
                print("회원가입에 대한 서버 응답을 확인하자! : \(value)")
                if value == "OK" {
                    self.transition(LoginViewController(), transitionStyle: .presentFullNavigation)
                } else {
                    self.showAlertMessageDetail(title: "<알림>", message: value) // 미완료
                }
            } onError: { error in
                print(error.localizedDescription)
                self.mainView.makeToast(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }

}

