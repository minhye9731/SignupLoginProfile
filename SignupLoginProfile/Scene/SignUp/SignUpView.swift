//
//  SignUpView.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/2/22.
//

import Foundation
import UIKit

class SignUpView: BaseView {
    
    let nameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "사용자 이름을 입력해주세요."
        textfield.tintColor = .black
        textfield.font = .systemFont(ofSize: 20)
        textfield.textAlignment = .center
        textfield.keyboardType = .default
        return textfield
    }()
    
    let emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "이메일을 입력해주세요."
        textfield.tintColor = .black
        textfield.font = .systemFont(ofSize: 20)
        textfield.textAlignment = .center
        textfield.keyboardType = .default
        return textfield
    }()
    
    let pwTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "비밀번호를 입력해주세요.(숫자 8자 이상)"
        textfield.tintColor = .black
        textfield.font = .systemFont(ofSize: 20)
        textfield.textAlignment = .center
        textfield.keyboardType = .numberPad
        return textfield
    }()
    
    let signUpButton: UIButton = {
       let button = UIButton()
        button.tintColor = .white
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemOrange
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        return button
    }()
    
    override func configureUI() {
        [nameTextField, emailTextField, pwTextField, signUpButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
    }
    
    
}
