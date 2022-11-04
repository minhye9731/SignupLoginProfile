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
        showProfile()
        viewModel.getProfile()
        bind()
    }
    
    func bind() {
        let input = ProfileViewModel.Input(tap: mainView.logoutButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.tap
            .bind { () in
                UserDefaults.token = ""
                
                // 화면전환 방법 수정 필요 (지금 로직대로면 계속 로그인/로그아웃을 반복할때마다 화면이 쌓임)
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
