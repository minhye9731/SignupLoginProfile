//
//  ProfileView.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/3/22.
//

import UIKit

class ProfileView: BaseView {
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .systemIndigo
        return image
    }()
    
    let emailLabel: UILabel = {
       let label = UILabel()
        label.textColor = .systemBlue
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .systemBlue
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    let logoutButton: UIButton = {
       let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 30
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        return button
    }()
    
    override func configureUI() {
        [titleLabel, profileImageView, emailLabel, nameLabel, logoutButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        let spacing = 20
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(spacing)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(spacing)
            make.height.equalTo(70)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(spacing)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(spacing)
            make.height.equalTo(profileImageView.snp.width).multipliedBy(1)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(spacing)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(spacing)
            make.height.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(spacing / 2)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(spacing)
            make.height.equalTo(40)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(spacing)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(spacing)
            make.height.equalTo(70)
        }
        
        
    }
    
    func setProfileData(data: Profile) {
        // 인디케이터 추가하자
        
        let url = URL(string: data.user.photo)!
        let imageData = try? Data(contentsOf: url)
        
        profileImageView.image = UIImage(data: imageData!)
            
        titleLabel.text = "\(data.user.username)님, 환영합니다! :)"
        emailLabel.text = "* E-mail : \(data.user.email)"
        nameLabel.text = "* 이름 : \(data.user.username)"
    }
    
}
