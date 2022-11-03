//
//  SignUpView.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/2/22.
//

import UIKit
import TextFieldEffects

final class SignUpView: BaseView {
    
    // MARK: - property
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "회원가입하기"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    let nameTextField: UITextField = {
        let textfield = MinoruTextField()
        textfield.placeholderColor = .darkGray
        textfield.placeholder = "사용자 이름을 입력해주세요."
        textfield.tintColor = .darkGray
        textfield.font = .systemFont(ofSize: 20)
        textfield.textAlignment = .center
        textfield.keyboardType = .default
        return textfield
    }()
    
    let emailTextField: UITextField = {
        let textfield = MinoruTextField()
        textfield.placeholderColor = .darkGray
        textfield.placeholder = "이메일을 입력해주세요."
        textfield.tintColor = .darkGray
        textfield.font = .systemFont(ofSize: 20)
        textfield.textAlignment = .center
        textfield.keyboardType = .default
        return textfield
    }()
    
    let pwTextField: UITextField = {
        let textfield = MinoruTextField()
        textfield.placeholderColor = .darkGray
        textfield.placeholder = "비밀번호를 입력해주세요."
        textfield.tintColor = .darkGray
        textfield.font = .systemFont(ofSize: 20)
        textfield.textAlignment = .center
        textfield.keyboardType = .numberPad
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    let validationLabel: UILabel = {
       let label = UILabel()
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .left
        return label
    }()
    
    let signUpButton: UIButton = {
       let button = UIButton()
        button.setTitle("회원가입하기", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 30
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        return button
    }()
    
    override func configureUI() {
        [titleLabel, nameTextField, emailTextField, pwTextField, validationLabel, signUpButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        let spacing = 20
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(spacing)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(spacing)
            make.height.equalTo(70)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(spacing)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(spacing)
            make.height.equalTo(70)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(spacing)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(spacing)
            make.height.equalTo(70)
        }
        
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(spacing)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(spacing)
            make.height.equalTo(70)
        }
        
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(4)
            make.leading.equalTo(pwTextField.snp.leading)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(validationLabel.snp.bottom).offset(spacing)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(spacing)
            make.height.equalTo(70)
        }
        
    }
    
    
}
