//
//  SignUpViewModel.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/3/22.
//

import Foundation
import RxSwift
import RxCocoa

class SignUpViewModel: CommonViewModel {
    
    let validText = BehaviorRelay(value: "비민번호는 최소 8글자 이상입니다.")
    
    struct Input {
//        let nameText: ControlProperty<String?>
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
//        let nameResultText = input.nameText
//            .orEmpty
//            .map { $0.count >= 1 }
//            .share()
//
//        let emailResultText = input.emailText
//            .orEmpty
//            .map { $0.contains("@") }
//            .share()
        
        let pwResultText = input.pwText
            .orEmpty // 옵셔널 해제
            .map { $0.count >= 8 } // 8글자 넘음
            .share()
        
//        let resultStatus = nameResultText && emailResultText && pwResultText
        
        let text = validText.asDriver()
        
        return Output(validStatus: pwResultText, validText: text, tap: input.tap)
    }
    
    
    
    
}
