//
//  LoginViewModel.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/3/22.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: CommonViewModel {
    
    let validText = BehaviorRelay(value: "비민번호는 최소 8글자 이상입니다.")
    
    struct Input {
        //        let emailText: ControlProperty<String?>
        let pwText: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validStatus: Observable<Bool>
        let validText: Driver<String>
        let tap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let pwResultText = input.pwText
            .orEmpty
            .map { $0.count >= 8 }
            .share() // share 대신에 driver, asdriver 로 써볼 수도 있음
        
        let text = validText.asDriver()
        
        return Output(validStatus: pwResultText, validText: text, tap: input.tap)
    }
    
}



