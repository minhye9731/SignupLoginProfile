//
//  SignUpViewModel.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/3/22.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpViewModel: CommonViewModel {
    
    // MARK: - property
    let signup = PublishSubject<String>()
    let validText = BehaviorRelay(value: "비밀번호는 최소 8글자 이상입니다.")
    
    struct Input {
        let nameText: ControlProperty<String?>
        let emailText: ControlProperty<String?>
        let pwText: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validStatus: Observable<Bool>
        let validText: Driver<String>
        let tap: ControlEvent<Void>
    }
    
    // MARK: - functions
    func transform(input: Input) -> Output {
        
        let nameTextResult = input.nameText
            .orEmpty
            .map { $0.count >= 1 && !$0.isEmpty }
            .share()

        let emailTextResult = input.emailText
            .orEmpty
            .map { $0.contains("@") && $0.contains(".") && $0.count > 5 }
            .share()
        
        let pwTextResult = input.pwText
            .orEmpty
            .map { $0.count >= 8 }
            .share()
        
        let resultStatus = Observable.combineLatest(nameTextResult, emailTextResult, pwTextResult) {
            $0 && $1 && $2
        }
            .share()
        
        let text = validText.asDriver()
        
        return Output(validStatus: resultStatus, validText: text, tap: input.tap)
    }
    
    
    // 회원가입 post 통신
    func getSignUp(name: String, email: String, pw: String) {
        
        let api = APIRouter.signup(userName: name, email: email, password: pw)
        Network.share.requestSignup(router: api) { [weak self] response in
            
            switch response {
            case .success(let success):
                self?.signup.onNext(success)
                print(success)
            case .failure(let failure):
                self?.signup.onError(failure)
                print(failure.localizedDescription)
            }
        }
    }
    
}
