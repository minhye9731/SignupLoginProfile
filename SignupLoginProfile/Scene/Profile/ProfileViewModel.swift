//
//  ProfileViewModel.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/3/22.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel: CommonViewModel {
    
    struct Input {
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let tap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        
        return Output(tap: input.tap)
    }
    
}
