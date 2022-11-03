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

final class ProfileViewController: BaseViewController {
    
    // MARK: - property
    let mainView = ProfileView()
    let viewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - lifecycle
    override func loadView() {
        self.view = mainView
    }
    
    // MARK: - functions
    override func configure() {
        viewModel.getProfile()
        showProfile()
        bind()
    }
    
    func bind() {
        let input = ProfileViewModel.Input(tap: mainView.logoutButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.tap
            .bind { () in
                UserDefaults.standard.removeObject(forKey: "token")
                let vc = SignUpViewController()
                self.transition(vc, transitionStyle: .presentFullNavigation)
            }
            .disposed(by: disposeBag)
    }
    
    func showProfile() {
        viewModel.profile
            .withUnretained(self)
            .subscribe { (vc, value) in
                self.mainView.setProfileData(data: value)
            } onError: { error in // Object, Error
                self.showAlertMessageDetail(title: "<알림>", message: "123") // 미완성
            }
            .disposed(by: disposeBag)
    }
}
