//
//  LoginViewModel.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/3/22.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginViewModel: CommonViewModel {
    
    // MARK: - property
    let login = PublishSubject<Login>()
    let validText = BehaviorRelay(value: "비민번호는 최소 8글자 이상입니다.")
    
    struct Input {
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
        let emailTextResult = input.emailText
            .orEmpty
            .map { $0.contains("@") && $0.contains(".") && $0.count > 5 }
            .share()
        
        let pwTextResult = input.pwText
            .orEmpty
            .map { $0.count >= 8 }
            .share()
        
        let resultStatus = Observable.combineLatest(emailTextResult, pwTextResult) { $0 && $1 }
            .share()
        
        let text = validText.asDriver()
        
        return Output(validStatus: resultStatus, validText: text, tap: input.tap)
    }
    
    func getLogin(email: String, pw: String) {
        let api = APIRouter.login(email: email, password: pw)
        Network.share.requestSeSAC(type: Login.self, router: api) { [weak self] response in
            
            switch response {
            case .success(let success):
                self?.login.onNext(success)
            case .failure(let failure):
                self?.login.onError(failure)
            }
        }
    }
}



